import 'package:career_portal/core/enterprise/enterprise_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final enterpriseIdProvider = Provider<int>((ref) {
  final revision = EnterpriseSession.revision;
  void onChange() => ref.invalidateSelf();
  revision.addListener(onChange);
  ref.onDispose(() => revision.removeListener(onChange));
  return EnterpriseSession.id;
});
