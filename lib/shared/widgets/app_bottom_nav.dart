import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants/app_strings.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNav({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/home');
            break;
          case 2:
            context.go('/practice');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: AppStrings.homeLabel),
        NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: AppStrings.learnLabel),
        NavigationDestination(icon: Icon(Icons.fitness_center_outlined), label: AppStrings.practiceLabel),
        NavigationDestination(icon: Icon(Icons.person_outline), label: AppStrings.profileLabel),
      ],
    );
  }
}
