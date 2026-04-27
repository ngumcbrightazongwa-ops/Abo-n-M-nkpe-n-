import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/constants/app_strings.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

enum LearnerTrack { kids, teens, adults, diaspora }

extension LearnerTrackX on LearnerTrack {
  String get title {
    switch (this) {
      case LearnerTrack.kids:
        return 'Kids';
      case LearnerTrack.teens:
        return 'Teens';
      case LearnerTrack.adults:
        return 'Adults';
      case LearnerTrack.diaspora:
        return 'Diaspora / Heritage';
    }
  }

  String get subtitle {
    switch (this) {
      case LearnerTrack.kids:
        return 'Short lessons, playful practice';
      case LearnerTrack.teens:
        return 'School-friendly pacing';
      case LearnerTrack.adults:
        return 'Practical everyday phrases';
      case LearnerTrack.diaspora:
        return 'Reconnect with family language';
    }
  }
}

class LearnerTrackScreen extends StatelessWidget {
  const LearnerTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tracks = LearnerTrack.values;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.chooseTrackTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You can change this later.',
                style: AppTextStyles.bodyMuted,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: tracks.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final track = tracks[index];
                    return AppCard(
                      onTap: () => context.goNamed(RouteNames.home),
                      child: Row(
                        children: [
                          const Icon(Icons.school),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(track.title, style: AppTextStyles.title),
                                const SizedBox(height: 4),
                                Text(track.subtitle, style: AppTextStyles.bodyMuted),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

