import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_employer_info_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_company_card_content.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_company_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardJobDetailCompanyCard extends ConsumerWidget {
  const DashboardJobDetailCompanyCard({
    super.key,
    required this.postingGuid,
    this.embedded = false,
  });

  final String postingGuid;
  final bool embedded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employerInfoAsync = ref.watch(
      jobPostingEmployerInfoProvider(postingGuid),
    );

    return employerInfoAsync.when(
      loading: () => DashboardJobDetailCompanyCardSkeleton(embedded: embedded),
      error: (_, _) => const SizedBox.shrink(),
      data: (company) => DashboardJobDetailCompanyCardContent(
        company: company,
        embedded: embedded,
      ),
    );
  }
}
