import 'package:flutter/material.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dashboard_header.dart';

class DashboardDesktopLayout extends StatelessWidget {
  const DashboardDesktopLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              Expanded(child: child),
              const DashboardFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
