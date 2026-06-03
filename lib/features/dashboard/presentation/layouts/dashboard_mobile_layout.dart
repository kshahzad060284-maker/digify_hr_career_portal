import 'package:flutter/material.dart';
import '../widgets/dashboard_content.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dashboard_header.dart';

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(),
            Expanded(child: DashboardContent()),
            DashboardFooter(),
          ],
        ),
      ),
    );
  }
}
