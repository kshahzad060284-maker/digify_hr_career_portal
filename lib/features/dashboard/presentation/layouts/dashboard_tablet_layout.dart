import 'package:flutter/material.dart';

import '../../../../core/services/responsive/responsive_helper.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dashboard_header.dart';

class DashboardTabletLayout extends StatelessWidget {
  const DashboardTabletLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.maxContentWidth(context),
            ),
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
      ),
    );
  }
}
