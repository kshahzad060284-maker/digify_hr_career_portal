import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_content.dart';
import 'package:flutter/material.dart';

class DashboardJobDetailBody extends StatelessWidget {
  const DashboardJobDetailBody({
    super.key,
    required this.job,
    required this.hasApplied,
  });

  final DashboardJob job;
  final bool hasApplied;

  @override
  Widget build(BuildContext context) {
    return DashboardJobDetailContent(
      job: job,
      hasApplied: hasApplied,
      showSurface: true,
    );
  }
}
