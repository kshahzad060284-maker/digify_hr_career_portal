import 'package:career_portal/features/auth/presentation/widgets/auth_form_helpers.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:flutter/material.dart';
export 'package:career_portal/features/auth/presentation/widgets/auth_form_helpers.dart';

class RegisterIconCircle extends StatelessWidget {
  const RegisterIconCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthIconCircle(assetPath: Assets.icons.auth.signUp.path);
  }
}

typedef RegisterAuthField = AuthFormField;

typedef RegisterResponsiveRow = AuthResponsiveRow;
