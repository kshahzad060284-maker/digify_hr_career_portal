import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_content_header.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/job_listing_content.dart';
import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardContentHeader(),
        Expanded(child: JobListingContent()),
      ],
    );
  }
}
