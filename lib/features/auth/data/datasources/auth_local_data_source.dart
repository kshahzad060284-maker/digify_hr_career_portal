import 'package:career_portal/features/auth/data/local/auth_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({Box<String>? box}) : _box = box ?? AuthHive.box;

  final Box<String> _box;

  Future<void> saveCandidateGuid(String candidateGuid) async {
    await _box.put(AuthHive.candidateGuidKey, candidateGuid);
  }

  String? readCandidateGuid() {
    final value = _box.get(AuthHive.candidateGuidKey);
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }

  Future<void> clear() async {
    await _box.delete(AuthHive.candidateGuidKey);
  }
}
