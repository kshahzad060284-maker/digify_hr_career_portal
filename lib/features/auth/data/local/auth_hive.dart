import 'package:hive_ce_flutter/hive_flutter.dart';

abstract final class AuthHive {
  AuthHive._();

  static const String boxName = 'auth_session';
  static const String candidateGuidKey = 'candidate_guid';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(boxName);
  }

  static Box<String> get box => Hive.box<String>(boxName);
}
