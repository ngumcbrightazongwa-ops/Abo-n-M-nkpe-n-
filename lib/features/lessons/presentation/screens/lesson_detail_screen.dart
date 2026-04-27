import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../lessons_providers.dart';

class LessonDetailScreen extends ConsumerWidget {
  final String lessonId;

  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonAsync = ref.watch(lessonDetailProvider(lessonId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: lessonAsync.when(
            loading: () => const LoadingWidget(label: 'Loading...'),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: (lesson) {
              if (lesson == null) return const Center(child: Text('Lesson not found'));

              return ListView(
                children: [
                  Text(lesson.title, style: AppTextStyles.headline),
                  const SizedBox(height: 8),
                  Text(lesson.description, style: AppTextStyles.bodyMuted),
                  const SizedBox(height: 16),
                  Text('Exercises (placeholder)', style: AppTextStyles.title),
                  const SizedBox(height: 10),
                  for (final ex in lesson.exercises)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ex.prompt, style: AppTextStyles.body),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (final opt in ex.options)
                                  Chip(
                                    label: Text(opt),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

