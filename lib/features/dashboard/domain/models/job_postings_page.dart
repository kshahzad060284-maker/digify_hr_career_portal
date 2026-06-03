import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';

class JobPostingsPage {
  const JobPostingsPage({
    required this.jobs,
    required this.pagination,
    required this.currentPage,
    required this.pageSize,
  });

  final List<DashboardJob> jobs;
  final PaginationInfo pagination;
  final int currentPage;
  final int pageSize;
}
