import 'package:web/web.dart' as web;

void dismissHtmlSplash() {
  web.window.dispatchEvent(web.CustomEvent('digify-app-ready'));
}
