import 'package:career_portal/core/providers/app_service_provider.dart';
import 'package:career_portal/features/applications/application/use_cases/get_candidate_applications_use_case.dart';
import 'package:career_portal/features/applications/data/datasources/candidate_applications_remote_data_source.dart';
import 'package:career_portal/features/applications/data/repositories/candidate_applications_repository_impl.dart';
import 'package:career_portal/features/applications/domain/repositories/candidate_applications_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final candidateApplicationsRemoteDataSourceProvider =
    Provider<CandidateApplicationsRemoteDataSource>((ref) {
      return CandidateApplicationsRemoteDataSource(
        ref.watch(appServiceProvider),
      );
    });

final candidateApplicationsRepositoryProvider =
    Provider<CandidateApplicationsRepository>((ref) {
      return CandidateApplicationsRepositoryImpl(
        ref.watch(candidateApplicationsRemoteDataSourceProvider),
      );
    });

final getCandidateApplicationsUseCaseProvider =
    Provider<GetCandidateApplicationsUseCase>((ref) {
      return GetCandidateApplicationsUseCase(
        ref.watch(candidateApplicationsRepositoryProvider),
      );
    });
