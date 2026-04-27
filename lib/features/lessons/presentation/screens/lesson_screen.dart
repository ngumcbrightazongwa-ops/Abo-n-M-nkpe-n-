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
import '../../../../shared/widgets/loading_widget.dart';
import '../lessons_providers.dart';
import '../widgets/lesson_header.dart';
import '../widgets/listen_repeat_card.dart';
import '../widgets/practice_options.dart';
import '../widgets/speaking_practice_card.dart';
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

final isRecordingProvider = StateProvider.family<bool, String>((ref, lessonId) => false);

class LessonScreen extends ConsumerWidget {
  final String lessonId;

  const LessonScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonAsync = ref.watch(lessonDetailProvider(lessonId));
    final isRecording = ref.watch(isRecordingProvider(lessonId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        actions: [
          TextButton(
            onPressed: () => context.goNamed(RouteNames.home),
            child: const Text('Exit'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: lessonAsync.when(
            loading: () => const LoadingWidget(label: 'Loading lesson...'),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: (lesson) {
              if (lesson == null) {
                return const Center(child: Text('Lesson not found'));
              }

              final vocab = lesson.vocabulary.isNotEmpty ? lesson.vocabulary.first : null;

              return Column(
                children: [
                  LessonHeader(title: lesson.title, progress: 0.2),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        if (vocab != null) ...[
                          WordCard(
                            word: vocab.word,
                            pronunciation: vocab.pronunciation,
                            meaning: vocab.meaning,
                            category: vocab.category,
                          ),
                          const SizedBox(height: 12),
                          ListenRepeatCard(
                            onListen: () async {
                              context.showSnack('Audio pronunciation will be added soon.');
                              await ref.read(audioPlayerServiceProvider).stop();
                            },
                          ),
                          const SizedBox(height: 12),
                          SpeakingPracticeCard(
                            isRecording: isRecording,
                            onRequestPermission: () async {
                              final ok = await ref.read(permissionServiceProvider).requestMicrophone();
                              if (!context.mounted) return;
                              context.showSnack(ok ? 'Microphone enabled' : 'Microphone permission denied');
                            },
                            onToggleRecording: () async {
                              final recorder = ref.read(audioRecorderServiceProvider);
                              final notifier = ref.read(isRecordingProvider(lessonId).notifier);

                              if (isRecording) {
                                final path = await recorder.stop();
                                notifier.state = false;
                                if (!context.mounted) return;
                                context.showSnack(path == null ? 'Recording stopped' : 'Saved recording');
                              } else {
                                final ok = await recorder.hasPermission();
                                if (!ok) {
                                  if (!context.mounted) return;
                                  context.showSnack('Microphone permission required');
                                  return;
                                }
                                await recorder.start();
                                notifier.state = true;
                                if (!context.mounted) return;
                                context.showSnack('Recording...');
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          const PracticeOptions(options: ['Listen', 'Repeat', 'Quick quiz']),
                        ] else ...[
                          const Text('No vocabulary found for this lesson.'),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.goNamed(
                      RouteNames.lessonDetail,
                      pathParameters: {'lessonId': lessonId},
                    ),
                    child: const Text(AppStrings.continueLabel),
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
