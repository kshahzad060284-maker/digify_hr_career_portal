import 'package:career_portal/features/auth/presentation/controllers/register_controller.dart';
import 'package:career_portal/features/auth/presentation/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerControllerProvider =
    NotifierProvider<RegisterController, RegisterState>(RegisterController.new);
