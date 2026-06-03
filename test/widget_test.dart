import 'package:flutter_test/flutter_test.dart';

import 'package:career_portal/app/app.dart';

void main() {
  testWidgets('renders the career portal home page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CareerPortalApp());

    expect(find.text('Career Portal'), findsOneWidget);
    expect(find.text('Featured Jobs'), findsOneWidget);
    expect(find.text('Browse jobs'), findsOneWidget);
  });
}
