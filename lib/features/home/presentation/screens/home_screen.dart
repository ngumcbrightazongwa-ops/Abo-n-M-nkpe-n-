import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/constants/app_strings.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/app_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.learnLabel)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: ListView(
            children: [
              Text('Unit 1', style: AppTextStyles.caption),
              const SizedBox(height: 6),
              Text('Greetings', style: AppTextStyles.headline),
              const SizedBox(height: 12),
              AppCard(
                onTap: () => context.go('/lesson/greetings_1'),
                child: Row(
                  children: [
                    const Icon(Icons.waving_hand),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lesson 1', style: AppTextStyles.title),
                          const SizedBox(height: 4),
                          Text(
                            'Start with “Good morning”',
                            style: AppTextStyles.bodyMuted,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Row(
                  children: [
                    const Icon(Icons.cloud_off),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Offline-first: lessons load from local seed data for now.',
                        style: AppTextStyles.bodyMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(selectedIndex: 1),
    );
  }
}
