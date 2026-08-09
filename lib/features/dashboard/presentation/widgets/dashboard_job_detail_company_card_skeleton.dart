import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_company_card_content.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardJobDetailCompanyCardSkeleton extends StatelessWidget {
  const DashboardJobDetailCompanyCardSkeleton({super.key});

  static const JobCompanyInfo _mockCompany = JobCompanyInfo(
    name: 'Company Name Placeholder',
    industry: 'Industry',
    information:
        'Short company information placeholder used while employer details are loading.',
    about:
        'Detailed company overview placeholder used while employer details are loading from the server.',
  );

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      enabled: true,
      child: DashboardJobDetailCompanyCardContent(company: _mockCompany),
    );
  }
}
