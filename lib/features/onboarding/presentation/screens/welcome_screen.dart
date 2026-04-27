import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_assets.dart';
import '../../../../app/constants/app_sizes.dart';
import '../../../../app/constants/app_strings.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              AppCard(
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.mascotPlaceholder,
                      width: 56,
                      height: 56,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(width: 56, height: 56);
                      },
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.welcomeTitle, style: AppTextStyles.headline),
                          const SizedBox(height: 6),
                          Text(
                            AppStrings.welcomeSubtitle,
                            style: AppTextStyles.bodyMuted,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: AppStrings.continueLabel,
                onPressed: () => context.goNamed(RouteNames.learnerTrack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

