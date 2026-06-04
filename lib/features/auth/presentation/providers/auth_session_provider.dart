import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSessionState {
  const AuthSessionState({this.session});

  final CandidateSession? session;

  String? get candidateUserGuid => session?.candidateUserGuid;

  bool get isLoggedIn => session?.isLoggedIn ?? false;
}

class AuthSessionNotifier extends Notifier<AuthSessionState> {
  @override
  AuthSessionState build() => const AuthSessionState();

  void setSession(CandidateSession session) {
    state = AuthSessionState(session: session);
  }

  void clear() {
    state = const AuthSessionState();
  }
}

final authSessionProvider =
    NotifierProvider<AuthSessionNotifier, AuthSessionState>(
      AuthSessionNotifier.new,
    );

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authSessionProvider).isLoggedIn;
});
