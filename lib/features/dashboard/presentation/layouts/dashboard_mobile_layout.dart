import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({
    super.key,
    required this.child,
    this.showOffersNavButton = true,
    this.showApplicationsNavButton = true,
    this.showShellHeader = true,
  });

  final Widget child;
  final bool showOffersNavButton;
  final bool showApplicationsNavButton;
  final bool showShellHeader;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showShellHeader)
              DashboardHeader(
                showOffersNavButton: showOffersNavButton,
                showApplicationsNavButton: showApplicationsNavButton,
              ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
