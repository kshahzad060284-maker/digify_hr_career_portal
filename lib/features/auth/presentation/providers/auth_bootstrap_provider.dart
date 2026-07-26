import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Restores the logged-in session from Hive on cold start.
///
/// Reads persisted `candidate_guid`, fetches header profile fields, and hydrates
/// [authSessionProvider]. On failure, clears the stored guid and stays logged out.
final authBootstrapProvider = FutureProvider<void>((ref) async {
  final candidateGuid = ref.read(readCandidateGuidUseCaseProvider).call();
  if (candidateGuid == null || candidateGuid.isEmpty) {
    return;
  }

  try {
    final session = await ref
        .read(getCandidateProfileUseCaseProvider)
        .call(
          candidateGuid: candidateGuid,
          enterpriseId: ref.read(enterpriseIdProvider),
        );
    await ref.read(authSessionProvider.notifier).setSession(session);
  } catch (_) {
    await ref.read(authSessionProvider.notifier).clear();
  }
});
