import 'package:career_portal/core/providers/app_service_provider.dart';
import 'package:career_portal/features/auth/application/use_cases/login_use_case.dart';
import 'package:career_portal/features/auth/application/use_cases/register_candidate_use_case.dart';
import 'package:career_portal/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:career_portal/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(appServiceProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final registerCandidateUseCaseProvider = Provider<RegisterCandidateUseCase>((
  ref,
) {
  return RegisterCandidateUseCase(ref.watch(authRepositoryProvider));
});
