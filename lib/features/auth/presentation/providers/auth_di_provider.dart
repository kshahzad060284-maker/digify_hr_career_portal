import 'package:career_portal/core/providers/app_service_provider.dart';
import 'package:career_portal/features/auth/application/use_cases/clear_candidate_guid_use_case.dart';
import 'package:career_portal/features/auth/application/use_cases/get_candidate_profile_use_case.dart';
import 'package:career_portal/features/auth/application/use_cases/login_use_case.dart';
import 'package:career_portal/features/auth/application/use_cases/read_candidate_guid_use_case.dart';
import 'package:career_portal/features/auth/application/use_cases/register_candidate_use_case.dart';
import 'package:career_portal/features/auth/application/use_cases/save_candidate_guid_use_case.dart';
import 'package:career_portal/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:career_portal/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:career_portal/features/auth/data/repositories/auth_local_repository_impl.dart';
import 'package:career_portal/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_local_repository.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(appServiceProvider));
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
});

final authLocalRepositoryProvider = Provider<AuthLocalRepository>((ref) {
  return AuthLocalRepositoryImpl(ref.watch(authLocalDataSourceProvider));
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final registerCandidateUseCaseProvider = Provider<RegisterCandidateUseCase>((
  ref,
) {
  return RegisterCandidateUseCase(ref.watch(authRepositoryProvider));
});

final getCandidateProfileUseCaseProvider = Provider<GetCandidateProfileUseCase>(
  (ref) {
    return GetCandidateProfileUseCase(ref.watch(authRepositoryProvider));
  },
);

final saveCandidateGuidUseCaseProvider = Provider<SaveCandidateGuidUseCase>((
  ref,
) {
  return SaveCandidateGuidUseCase(ref.watch(authLocalRepositoryProvider));
});

final readCandidateGuidUseCaseProvider = Provider<ReadCandidateGuidUseCase>((
  ref,
) {
  return ReadCandidateGuidUseCase(ref.watch(authLocalRepositoryProvider));
});

final clearCandidateGuidUseCaseProvider = Provider<ClearCandidateGuidUseCase>((
  ref,
) {
  return ClearCandidateGuidUseCase(ref.watch(authLocalRepositoryProvider));
});
