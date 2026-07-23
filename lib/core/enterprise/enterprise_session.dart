import 'dart:async';

import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/deep_link/deep_link.dart';
import 'package:flutter/foundation.dart';

abstract final class EnterpriseSession {
  EnterpriseSession._();

  static int id = AppConfig.defaultEnterpriseId;
  static bool _capturedFromUrl = false;
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static bool get wasCapturedFromUrl => _capturedFromUrl;

  static String? syncFromUri(Uri uri) {
    final fromUrl = DeepLink.enterpriseIdOf(uri);
    if (fromUrl != null) {
      _capture(fromUrl);
      return null;
    }

    if (!_capturedFromUrl) return null;
    if (uri.queryParameters.containsKey(DeepLink.enterpriseIdParam)) {
      return null;
    }

    return DeepLink.withEnterpriseId(uri.toString(), id);
  }

  static void _capture(int newId) {
    if (id == newId && _capturedFromUrl) return;
    id = newId;
    _capturedFromUrl = true;
    scheduleMicrotask(() => revision.value++);
  }
}
