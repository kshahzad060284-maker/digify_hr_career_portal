import 'package:career_portal/app/app.dart';
import 'package:career_portal/features/auth/data/local/auth_hive.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  await AuthHive.init();
  runApp(const ProviderScope(child: CareerPortalApp()));
}
