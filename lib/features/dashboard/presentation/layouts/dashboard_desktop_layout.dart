import 'package:flutter/material.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dashboard_header.dart';

class DashboardDesktopLayout extends StatelessWidget {
  const DashboardDesktopLayout({
    super.key,
    required this.child,
    this.showOffersNavButton = true,
    this.showApplicationsNavButton = true,
  });

  final Widget child;
  final bool showOffersNavButton;
  final bool showApplicationsNavButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHeader(
                showOffersNavButton: showOffersNavButton,
                showApplicationsNavButton: showApplicationsNavButton,
              ),
              Expanded(child: child),
              const DashboardFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
