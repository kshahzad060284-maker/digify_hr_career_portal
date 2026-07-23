import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/applications/domain/models/candidate_application.dart';

class CandidateApplicationsPage {
  const CandidateApplicationsPage({
    required this.applications,
    required this.pagination,
    required this.currentPage,
    required this.pageSize,
  });

  final List<CandidateApplication> applications;
  final PaginationInfo pagination;
  final int currentPage;
  final int pageSize;
}
