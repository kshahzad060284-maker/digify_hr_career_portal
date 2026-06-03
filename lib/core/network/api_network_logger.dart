import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract final class ApiNetworkLogger {
  ApiNetworkLogger._();

  static const _name = 'ApiNetwork';
  static const _reset = '\x1B[0m';
  static const _dim = '\x1B[90m';

  // Request — cyan
  static const _requestTitle = '\x1B[96m\x1B[1m';
  static const _requestLabel = '\x1B[36m';
  static const _requestValue = '\x1B[96m';

  // Response — green
  static const _responseTitle = '\x1B[92m\x1B[1m';
  static const _responseLabel = '\x1B[32m';
  static const _responseValue = '\x1B[92m';

  // Error — red
  static const _errorTitle = '\x1B[91m\x1B[1m';
  static const _errorLabel = '\x1B[31m';
  static const _errorValue = '\x1B[91m';

  static void logRequest(RequestOptions options) {
    if (!kDebugMode) return;

    markRequestStart(options);

    final buffer = StringBuffer()
      ..writeln(_line(_requestTitle, '▶ HTTP REQUEST'))
      ..writeln(_field(_requestLabel, 'Method', options.method, _requestValue))
      ..writeln(
        _field(_requestLabel, 'URL', options.uri.toString(), _requestValue),
      );

    if (options.queryParameters.isNotEmpty) {
      buffer.writeln(
        _field(
          _requestLabel,
          'Query',
          _formatPayload(options.queryParameters),
          _requestValue,
        ),
      );
    }

    final headers = _sanitizeHeaders(options.headers);
    if (headers.isNotEmpty) {
      buffer.writeln(
        _field(
          _requestLabel,
          'Headers',
          _formatPayload(headers),
          _requestValue,
        ),
      );
    }

    buffer.writeln(
      _field(
        _requestLabel,
        'Body',
        _formatPayload(options.data),
        _requestValue,
      ),
    );

    _emit(buffer.toString().trimRight(), colorPrefix: _requestTitle);
  }

  static void logResponse(Response<dynamic> response) {
    if (!kDebugMode) return;

    final elapsed = response.requestOptions.extra['request_start_ms'];
    final durationLabel = elapsed is int
        ? '${DateTime.now().millisecondsSinceEpoch - elapsed}ms'
        : '—';

    final buffer = StringBuffer()
      ..writeln(_line(_responseTitle, '◀ HTTP RESPONSE'))
      ..writeln(
        _field(
          _responseLabel,
          'Status',
          '${response.statusCode ?? '—'} ${response.statusMessage ?? ''}'
              .trim(),
          _responseValue,
        ),
      )
      ..writeln(
        _field(
          _responseLabel,
          'Method',
          response.requestOptions.method,
          _responseValue,
        ),
      )
      ..writeln(
        _field(
          _responseLabel,
          'URL',
          response.realUri.toString(),
          _responseValue,
        ),
      )
      ..writeln(
        _field(_responseLabel, 'Duration', durationLabel, _responseValue),
      )
      ..writeln(
        _field(
          _responseLabel,
          'Body',
          _formatPayload(response.data),
          _responseValue,
        ),
      );

    _emit(buffer.toString().trimRight(), colorPrefix: _responseTitle);
  }

  static void logError(DioException error) {
    if (!kDebugMode) return;

    final response = error.response;
    final buffer = StringBuffer()
      ..writeln(_line(_errorTitle, '✖ HTTP ERROR'))
      ..writeln(_field(_errorLabel, 'Type', error.type.name, _errorValue))
      ..writeln(
        _field(_errorLabel, 'Method', error.requestOptions.method, _errorValue),
      )
      ..writeln(
        _field(
          _errorLabel,
          'URL',
          error.requestOptions.uri.toString(),
          _errorValue,
        ),
      );

    if (response != null) {
      buffer
        ..writeln(
          _field(
            _errorLabel,
            'Status',
            '${response.statusCode ?? '—'} ${response.statusMessage ?? ''}'
                .trim(),
            _errorValue,
          ),
        )
        ..writeln(
          _field(
            _errorLabel,
            'Response',
            _formatPayload(response.data),
            _errorValue,
          ),
        );
    } else {
      buffer.writeln(
        _field(
          _errorLabel,
          'Message',
          error.message ?? 'Unknown error',
          _errorValue,
        ),
      );
    }

    buffer.writeln(
      _field(
        _errorLabel,
        'Request body',
        _formatPayload(error.requestOptions.data),
        _errorValue,
      ),
    );

    _emit(buffer.toString().trimRight(), colorPrefix: _errorTitle);
  }

  static void markRequestStart(RequestOptions options) {
    options.extra['request_start_ms'] = DateTime.now().millisecondsSinceEpoch;
  }

  static String _line(String color, String title) {
    return '$color$title$_reset $_dim${_separator()}$_reset';
  }

  static String _field(
    String labelColor,
    String label,
    String value,
    String valueColor,
  ) {
    return '  $labelColor$label:$_reset $valueColor$value$_reset';
  }

  static String _separator() => '─' * 52;

  static String _formatPayload(dynamic data) {
    if (data == null) return '${_dim}null$_reset';

    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      if (data is FormData) {
        final fields = data.fields
            .map((e) => '${e.key}: ${e.value}')
            .join(', ');
        final files = data.files.map((e) => e.key).join(', ');
        return 'FormData(fields: [$fields], files: [$files])';
      }
      if (data is String) {
        final trimmed = data.trim();
        if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
          return const JsonEncoder.withIndent(
            '  ',
          ).convert(jsonDecode(trimmed));
        }
        return data;
      }
      return data.toString();
    } catch (_) {
      return data.toString();
    }
  }

  static Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    const sensitive = {'authorization', 'cookie', 'x-api-key', 'api-key'};
    final sanitized = <String, dynamic>{};

    headers.forEach((key, value) {
      if (sensitive.contains(key.toLowerCase())) {
        sanitized[key] = '***';
      } else {
        sanitized[key] = value;
      }
    });

    return sanitized;
  }

  static void _emit(String message, {required String colorPrefix}) {
    final output = kIsWeb
        ? _webStyled(message, colorPrefix)
        : '$colorPrefix$message$_reset';

    for (final line in output.split('\n')) {
      debugPrint(line, wrapWidth: 1024);
    }

    developer.log(message, name: _name);
  }

  static String _webStyled(String message, String colorPrefix) {
    if (colorPrefix == _requestTitle) {
      return message.replaceFirst('▶ HTTP REQUEST', '▶ REQUEST (cyan)');
    }
    if (colorPrefix == _responseTitle) {
      return message.replaceFirst('◀ HTTP RESPONSE', '◀ RESPONSE (green)');
    }
    if (colorPrefix == _errorTitle) {
      return message.replaceFirst('✖ HTTP ERROR', '✖ ERROR (red)');
    }
    return message;
  }
}
