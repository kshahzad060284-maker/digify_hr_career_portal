import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final enterpriseIdProvider = Provider<int>((ref) {
  final enterpriseId = ref.watch(hostEnterpriseIdProvider);
  if (enterpriseId == null) {
    throw StateError(
      'Enterprise context is not ready. Wait for EnterpriseContextBootstrap.',
    );
  }
  return enterpriseId;
});
