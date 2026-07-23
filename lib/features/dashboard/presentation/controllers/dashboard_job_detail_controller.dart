import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_di_provider.dart';
import 'package:career_portal/features/dashboard/presentation/state/dashboard_job_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardJobDetailController
    extends AutoDisposeFamilyAsyncNotifier<DashboardJobDetailState, String> {
  @override
  Future<DashboardJobDetailState> build(String postingGuid) async {
    ref.watch(enterpriseIdProvider);
    return _load(postingGuid);
  }

  Future<void> refresh() async {
    state = const AsyncLoading<DashboardJobDetailState>();
    state = await AsyncValue.guard(() => _load(arg));
  }

  Future<DashboardJobDetailState> _load(String postingGuid) async {
    final useCase = ref.read(getJobPostingUseCaseProvider);
    final job = await useCase(
      postingGuid: postingGuid,
      enterpriseId: ref.read(enterpriseIdProvider),
    );
    return DashboardJobDetailState(postingGuid: postingGuid, job: job);
  }
}
