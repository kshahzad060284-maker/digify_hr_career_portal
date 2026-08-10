import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/features/dashboard/domain/models/employer_assignment_type.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_di_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final enterpriseEmployerInfoProvider = FutureProvider<JobCompanyInfo>((
  ref,
) async {
  ref.keepAlive();

  final enterpriseId = ref.watch(enterpriseIdProvider);
  final useCase = ref.watch(getEmployerInfoUseCaseProvider);
  return useCase(
    enterpriseId: enterpriseId,
    assignmentType: EmployerAssignmentType.enterpriseLevel,
  );
});

final jobPostingEmployerInfoProvider = FutureProvider.autoDispose
    .family<JobCompanyInfo, String>((ref, postingGuid) async {
      final useCase = ref.watch(getJobPostingEmployerInfoUseCaseProvider);
      return useCase(postingGuid: postingGuid);
    });
