import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/app_extensions.dart';
import '../../core/router/app_routes.dart';
import '../../core/services/toast/toast_service.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Browse jobs', style: context.textTheme.headlineMedium),
          const Gap(16),
          _JobTile(
            title: 'UI / UX Designer',
            subtitle: 'Vertex Studio · Remote',
            onTap: () {
              ToastService.success(
                context,
                'Opening job details',
                title: 'Nice choice',
              );
              context.goNamed(
                AppRouteNames.jobDetails,
                pathParameters: {'id': '1'},
              );
            },
          ),
          _JobTile(
            title: 'Flutter Developer',
            subtitle: 'Northstar Labs · Lahore',
            onTap: () {
              ToastService.success(
                context,
                'Opening job details',
                title: 'Nice choice',
              );
              context.goNamed(
                AppRouteNames.jobDetails,
                pathParameters: {'id': '2'},
              );
            },
          ),
        ],
      ),
    );
  }
}

class _JobTile extends StatelessWidget {
  const _JobTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }
}
