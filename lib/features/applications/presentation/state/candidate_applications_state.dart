import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/applications/domain/models/candidate_application.dart';

class CandidateApplicationsState {
  const CandidateApplicationsState({
    required this.applications,
    required this.pagination,
    required this.currentPage,
    required this.pageSize,
  });

  final List<CandidateApplication> applications;
  final PaginationInfo pagination;
  final int currentPage;
  final int pageSize;

  static const empty = CandidateApplicationsState(
    applications: [],
    pagination: PaginationInfo(
      totalPages: 1,
      totalItems: 0,
      hasNext: false,
      hasPrevious: false,
    ),
    currentPage: 1,
    pageSize: 10,
  );
}
