import 'package:career_portal/features/applications/data/datasources/candidate_applications_remote_data_source.dart';
import 'package:career_portal/features/applications/domain/models/candidate_applications_page.dart';
import 'package:career_portal/features/applications/domain/repositories/candidate_applications_repository.dart';

class CandidateApplicationsRepositoryImpl
    implements CandidateApplicationsRepository {
  const CandidateApplicationsRepositoryImpl(this._remoteDataSource);

  final CandidateApplicationsRemoteDataSource _remoteDataSource;

  @override
  Future<CandidateApplicationsPage> getCandidateApplications({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  }) {
    return _remoteDataSource.getCandidateApplications(
      enterpriseId: enterpriseId,
      candidateGuid: candidateGuid,
      page: page,
      pageSize: pageSize,
    );
  }
}
