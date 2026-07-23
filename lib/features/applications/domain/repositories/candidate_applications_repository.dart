import 'package:career_portal/features/applications/domain/models/candidate_applications_page.dart';

abstract interface class CandidateApplicationsRepository {
  Future<CandidateApplicationsPage> getCandidateApplications({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  });
}
