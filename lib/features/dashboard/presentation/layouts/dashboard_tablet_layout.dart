import 'package:flutter/material.dart';

import '../../../../core/services/responsive/responsive_helper.dart';
import '../widgets/dashboard_content.dart';
import '../widgets/dashboard_footer.dart';
import '../widgets/dashboard_header.dart';

class DashboardTabletLayout extends StatelessWidget {
  const DashboardTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.maxContentWidth(context),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeader(),
                Expanded(child: DashboardContent()),
                DashboardFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
