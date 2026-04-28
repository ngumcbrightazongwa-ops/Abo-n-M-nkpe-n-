import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/constants/app_strings.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/audio/audio_recorder_service.dart';
import '../../../../core/permissions/permission_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../lessons_providers.dart';
import '../widgets/lesson_header.dart';
import '../widgets/listen_repeat_card.dart';
import '../widgets/meaning_breakdown_card.dart';
import '../widgets/practice_options.dart';
import '../widgets/word_card.dart';

final audioPlayerServiceProvider = Provider<AudioPlayerService>((ref) {
  final service = AudioPlayerService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

final audioRecorderServiceProvider = Provider<AudioRecorderService>((ref) {
  final service = AudioRecorderService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

final isRecordingProvider = StateProvider.family<bool, String>(
  (ref, lessonId) => false,
);

int _tryParseLessonNumber(String lessonId) {
  final match = RegExp(r'_(\d+)$').firstMatch(lessonId);
  return int.tryParse(match?.group(1) ?? '') ?? 1;
}

class LessonScreen extends ConsumerWidget {
  final String lessonId;

  const LessonScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonAsync = ref.watch(lessonDetailProvider(lessonId));
    final isRecording = ref.watch(isRecordingProvider(lessonId));
    final lessonNumber = _tryParseLessonNumber(lessonId);
    const totalLessons = 8;
    const coins = 120;
    const progress = 0.35;

    return Scaffold(
      body: SafeArea(
        child: lessonAsync.when(
          loading:
              () => const Center(
                child: LoadingWidget(label: AppStrings.lessonLoadingLabel),
              ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (lesson) {
            if (lesson == null) {
              return const Center(child: Text(AppStrings.lessonNotFoundLabel));
            }

            final vocab =
                lesson.vocabulary.isNotEmpty ? lesson.vocabulary.first : null;
            if (vocab == null) {
              return const Center(
                child: Text(AppStrings.noVocabularyFoundLabel),
              );
            }

            return ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.pagePadding,
                AppSizes.pagePadding,
                AppSizes.pagePadding,
                24,
              ),
              children: [
                LessonHeader(
                  overline: AppStrings.lessonOfLabel(
                    lessonNumber,
                    totalLessons,
                  ),
                  title: lesson.title,
                  progress: progress,
                  coins: coins,
                  onBack: () => context.pop(),
                ),
                const SizedBox(height: 16),
                WordCard(
                  word: vocab.word,
                  pronunciation: vocab.pronunciation,
                  meaning: vocab.meaning,
                  onPlay: () async {
                    context.showSnack(AppStrings.audioComingSoonLabel);
                    await ref.read(audioPlayerServiceProvider).stop();
                  },
                  onToggleFavorite:
                      () => context.showSnack(AppStrings.savedForPracticeLabel),
                ),
                const SizedBox(height: 12),
                ListenRepeatCard(
                  isRecording: isRecording,
                  onListen: () async {
                    context.showSnack(AppStrings.audioComingSoonLabel);
                    await ref.read(audioPlayerServiceProvider).stop();
                  },
                  onToggleRecording: () async {
                    final recorder = ref.read(audioRecorderServiceProvider);
                    final notifier = ref.read(
                      isRecordingProvider(lessonId).notifier,
                    );

                    if (isRecording) {
                      final path = await recorder.stop();
                      notifier.state = false;
                      if (!context.mounted) return;
                      context.showSnack(
                        path == null
                            ? AppStrings.recordingStoppedLabel
                            : AppStrings.savedRecordingLabel,
                      );
                      return;
                    }

                    final ok =
                        await ref
                            .read(permissionServiceProvider)
                            .requestMicrophone();
                    if (!ok) {
                      if (!context.mounted) return;
                      context.showSnack(
                        AppStrings.microphonePermissionRequiredLabel,
                      );
                      return;
                    }

                    await recorder.start();
                    notifier.state = true;
                    if (!context.mounted) return;
                    context.showSnack(AppStrings.recordingLabel);
                  },
                ),
                const SizedBox(height: 12),
                MeaningBreakdownCard(
                  text: AppStrings.meaningBreakdownText(vocab.word),
                ),
                const SizedBox(height: 14),
                PracticeOptions(options: [vocab.word, 'A bcla?', 'M̀ba!']),
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.pagePadding,
                12,
                AppSizes.pagePadding,
                12,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed:
                      () => context.goNamed(
                        RouteNames.lessonDetail,
                        pathParameters: {'lessonId': lessonId},
                      ),
                  child: const Text(AppStrings.continueLabel),
                ),
              ),
            ),
            const AppBottomNav(selectedIndex: 1),
          ],
        ),
      ),
    );
  }
}
