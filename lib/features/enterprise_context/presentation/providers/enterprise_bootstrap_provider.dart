import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_employer_info_provider.dart';
import 'package:career_portal/features/enterprise_context/domain/models/enterprise_context.dart';
import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _minBrandedLoadingDuration = Duration(seconds: 3);

final enterpriseBootstrapProvider = FutureProvider<EnterpriseContext>((
  ref,
) async {
  final startedAt = DateTime.now();
  final context = await ref.watch(enterpriseContextProvider.future);

  try {
    await ref.watch(enterpriseEmployerInfoProvider.future);
  } catch (_) {}

  final elapsed = DateTime.now().difference(startedAt);
  final remaining = _minBrandedLoadingDuration - elapsed;
  if (remaining > Duration.zero) {
    await Future<void>.delayed(remaining);
  }

  return context;
});
