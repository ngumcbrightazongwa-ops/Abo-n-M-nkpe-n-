import 'package:flutter/material.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/constants/app_strings.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/empty_state_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.profileLabel)),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: EmptyStateWidget(
            title: 'Profile coming soon',
            subtitle: 'Avatar, settings, and track selection will live here.',
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(selectedIndex: 3),
    );
  }
}
