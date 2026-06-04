import 'package:career_portal/features/auth/presentation/controllers/login_controller.dart';
import 'package:career_portal/features/auth/presentation/state/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);
