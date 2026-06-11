import 'package:flutter/material.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dashboard_header.dart';

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({
    super.key,
    required this.child,
    this.showOffersNavButton = true,
  });

  final Widget child;
  final bool showOffersNavButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(showOffersNavButton: showOffersNavButton),
            Expanded(child: child),
            const DashboardFooter(),
          ],
        ),
      ),
    );
  }
}
