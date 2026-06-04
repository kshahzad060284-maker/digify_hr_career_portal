import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';

class DashboardJobsState {
  const DashboardJobsState({
    required this.jobs,
    required this.pagination,
    required this.currentPage,
    required this.pageSize,
    this.search = '',
  });

  final List<DashboardJob> jobs;
  final PaginationInfo pagination;
  final int currentPage;
  final int pageSize;
  final String search;

  static const empty = DashboardJobsState(
    jobs: [],
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
