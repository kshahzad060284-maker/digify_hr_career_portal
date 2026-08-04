import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/app_config.dart';
import 'api_network_logger.dart';
import 'app_exception.dart';
import 'tenant_host.dart';

class AppService {
  AppService({
    Dio? dio,
    String? baseUrl,
    Map<String, dynamic>? defaultHeaders,
    this.enableLogging = kDebugMode,
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl ?? AppConfig.baseUrl,
               connectTimeout: AppConfig.connectTimeout,
               receiveTimeout: AppConfig.receiveTimeout,
               sendTimeout: AppConfig.sendTimeout,
               headers: defaultHeaders ?? AppConfig.defaultHeaders,
               responseType: ResponseType.json,
             ),
           ) {
    _dio.interceptors.add(TenantHostInterceptor());
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (enableLogging) {
            ApiNetworkLogger.logRequest(options);
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (enableLogging) {
            ApiNetworkLogger.logResponse(response);
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (enableLogging) {
            ApiNetworkLogger.logError(error);
          }
          handler.next(error);
        },
      ),
    );
  }

  final Dio _dio;
  final bool enableLogging;

  Dio get client => _dio;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? parser,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      method: 'GET',
      path: path,
      queryParameters: queryParameters,
      options: options,
      parser: parser,
      cancelToken: cancelToken,
    );
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? parser,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      method: 'POST',
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      parser: parser,
      cancelToken: cancelToken,
    );
  }

  Future<T> postMultipart<T>(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? parser,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      method: 'POST',
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(
        contentType: 'multipart/form-data',
      ),
      parser: parser,
      cancelToken: cancelToken,
    );
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? parser,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      method: 'PUT',
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      parser: parser,
      cancelToken: cancelToken,
    );
  }

  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? parser,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      method: 'PATCH',
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      parser: parser,
      cancelToken: cancelToken,
    );
  }

  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? parser,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      method: 'DELETE',
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      parser: parser,
      cancelToken: cancelToken,
    );
  }

  Future<T> _request<T>({
    required String method,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? parser,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.request<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
        cancelToken: cancelToken,
      );

      final responseData = response.data;

      if (parser != null) {
        return parser(responseData);
      }

      return responseData as T;
    } on DioException catch (error) {
      throw _mapDioException(error);
    } catch (error) {
      throw AppException(
        message: 'Something went wrong. Please try again.',
        details: error,
      );
    }
  }

  AppException _mapDioException(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final endpoint = error.requestOptions.path;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppException(
          message: 'Connection timed out.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: error,
        );
      case DioExceptionType.sendTimeout:
        return AppException(
          message: 'Request timed out while sending data.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: error,
        );
      case DioExceptionType.receiveTimeout:
        return AppException(
          message: 'Server took too long to respond.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: error,
        );
      case DioExceptionType.badResponse:
        return AppException(
          message:
              _extractErrorMessage(response?.data) ??
              'Request failed with status code $statusCode.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: response?.data,
        );
      case DioExceptionType.cancel:
        return AppException(
          message: 'Request was cancelled.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: error,
        );
      case DioExceptionType.connectionError:
        return AppException(
          message: 'No internet connection.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: error,
        );
      case DioExceptionType.unknown:
        return AppException(
          message: error.message ?? 'Unexpected network error.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: error,
        );
      case DioExceptionType.badCertificate:
        return AppException(
          message: 'Secure connection failed.',
          statusCode: statusCode,
          endpoint: endpoint,
          details: error,
        );
    }
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'] ?? data['detail'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
      if (message is List && message.isNotEmpty) {
        return message.first.toString();
      }
    }

    if (data is String && data.trim().isNotEmpty) {
      return data;
    }

    return null;
  }
}
