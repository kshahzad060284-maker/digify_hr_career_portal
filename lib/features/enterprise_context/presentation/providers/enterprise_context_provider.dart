import 'package:career_portal/core/providers/app_service_provider.dart';
import 'package:career_portal/features/enterprise_context/data/datasources/enterprise_context_remote_data_source.dart';
import 'package:career_portal/features/enterprise_context/data/repositories/enterprise_context_repository_impl.dart';
import 'package:career_portal/features/enterprise_context/domain/models/enterprise_context.dart';
import 'package:career_portal/features/enterprise_context/domain/repositories/enterprise_context_repository.dart';
import 'package:career_portal/features/enterprise_context/domain/usecases/get_enterprise_context_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final enterpriseContextRemoteDataSourceProvider =
    Provider<EnterpriseContextRemoteDataSource>((ref) {
      return EnterpriseContextRemoteDataSourceImpl(
        appService: ref.watch(appServiceProvider),
      );
    });

final enterpriseContextRepositoryProvider =
    Provider<EnterpriseContextRepository>((ref) {
      return EnterpriseContextRepositoryImpl(
        remoteDataSource: ref.watch(enterpriseContextRemoteDataSourceProvider),
      );
    });

final getEnterpriseContextUseCaseProvider =
    Provider<GetEnterpriseContextUseCase>((ref) {
      return GetEnterpriseContextUseCase(
        ref.watch(enterpriseContextRepositoryProvider),
      );
    });

final enterpriseContextProvider =
    AsyncNotifierProvider<EnterpriseContextNotifier, EnterpriseContext>(
      EnterpriseContextNotifier.new,
    );

final hostEnterpriseIdProvider = Provider<int?>((ref) {
  final enterpriseId = ref
      .watch(enterpriseContextProvider)
      .asData
      ?.value
      .enterpriseId;
  if (enterpriseId == null || enterpriseId <= 0) return null;
  return enterpriseId;
});

final hostCareerPortalUrlProvider = Provider<String?>((ref) {
  final url = ref
      .watch(enterpriseContextProvider)
      .asData
      ?.value
      .careerPortalUrl
      .trim();
  if (url == null || url.isEmpty) return null;
  return url;
});

final hostEnterpriseNameProvider = Provider<String?>((ref) {
  final name = ref
      .watch(enterpriseContextProvider)
      .asData
      ?.value
      .enterpriseName
      .trim();
  if (name == null || name.isEmpty) return null;
  return name;
});

class EnterpriseContextNotifier extends AsyncNotifier<EnterpriseContext> {
  @override
  Future<EnterpriseContext> build() => _fetch();

  Future<EnterpriseContext> _fetch() {
    return ref.read(getEnterpriseContextUseCaseProvider)();
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }
}
