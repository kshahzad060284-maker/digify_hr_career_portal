import 'package:career_portal/core/providers/app_service_provider.dart';
import 'package:career_portal/features/dashboard/application/use_cases/apply_job_use_case.dart';
import 'package:career_portal/features/dashboard/application/use_cases/get_job_posting_use_case.dart';
import 'package:career_portal/features/dashboard/application/use_cases/get_job_postings_use_case.dart';
import 'package:career_portal/features/dashboard/data/datasources/job_postings_remote_data_source.dart';
import 'package:career_portal/features/dashboard/data/repositories/job_postings_repository_impl.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobPostingsRemoteDataSourceProvider =
    Provider<JobPostingsRemoteDataSource>((ref) {
      return JobPostingsRemoteDataSource(ref.watch(appServiceProvider));
    });

final jobPostingsRepositoryProvider = Provider<JobPostingsRepository>((ref) {
  return JobPostingsRepositoryImpl(
    ref.watch(jobPostingsRemoteDataSourceProvider),
  );
});

final getJobPostingsUseCaseProvider = Provider<GetJobPostingsUseCase>((ref) {
  return GetJobPostingsUseCase(ref.watch(jobPostingsRepositoryProvider));
});

final getJobPostingUseCaseProvider = Provider<GetJobPostingUseCase>((ref) {
  return GetJobPostingUseCase(ref.watch(jobPostingsRepositoryProvider));
});

final applyJobUseCaseProvider = Provider<ApplyJobUseCase>((ref) {
  return ApplyJobUseCase(ref.watch(jobPostingsRepositoryProvider));
});
