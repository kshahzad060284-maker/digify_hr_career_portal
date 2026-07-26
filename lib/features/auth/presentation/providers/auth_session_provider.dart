import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSessionState {
  const AuthSessionState({this.session});

  final CandidateSession? session;

  String? get candidateUserGuid => session?.candidateUserGuid;

  String? get candidateGuid => session?.candidateGuid;

  bool get isLoggedIn => session?.isLoggedIn ?? false;
}

class AuthSessionNotifier extends Notifier<AuthSessionState> {
  @override
  AuthSessionState build() => const AuthSessionState();

  Future<void> setSession(CandidateSession session) async {
    state = AuthSessionState(session: session);
    final guid = session.candidateGuid.trim();
    if (guid.isNotEmpty) {
      await ref.read(saveCandidateGuidUseCaseProvider).call(guid);
    }
  }

  Future<void> clear() async {
    state = const AuthSessionState();
    await ref.read(clearCandidateGuidUseCaseProvider).call();
  }
}

final authSessionProvider =
    NotifierProvider<AuthSessionNotifier, AuthSessionState>(
      AuthSessionNotifier.new,
    );

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authSessionProvider).isLoggedIn;
});
