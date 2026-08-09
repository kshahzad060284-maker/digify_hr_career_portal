import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_di_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardJobEmployerInfoProvider = FutureProvider.autoDispose
    .family<JobCompanyInfo, String>((ref, postingGuid) async {
      ref.watch(enterpriseIdProvider);
      final useCase = ref.watch(getJobEmployerInfoUseCaseProvider);
      return useCase(
        postingGuid: postingGuid,
        enterpriseId: ref.read(enterpriseIdProvider),
      );
    });
