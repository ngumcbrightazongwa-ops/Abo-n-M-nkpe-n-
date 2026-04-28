import 'package:flutter/material.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/constants/app_strings.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/empty_state_widget.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.practiceLabel)),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: EmptyStateWidget(
            title: 'Practice coming soon',
            subtitle: 'This will include quizzes, speaking practice, and review.',
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(selectedIndex: 2),
    );
  }
}
