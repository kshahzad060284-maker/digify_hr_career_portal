import 'package:career_portal/features/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:career_portal/features/auth/presentation/state/forgot_password_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordControllerProvider =
    NotifierProvider.autoDispose<ForgotPasswordController, ForgotPasswordState>(
      ForgotPasswordController.new,
    );
