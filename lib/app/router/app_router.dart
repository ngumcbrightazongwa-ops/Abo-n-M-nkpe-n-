import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/lessons/presentation/screens/lesson_detail_screen.dart';
import '../../features/lessons/presentation/screens/lesson_screen.dart';
import '../../features/onboarding/presentation/screens/aha_moment_screen.dart';
import '../../features/onboarding/presentation/screens/celebration_screen.dart';
import '../../features/onboarding/presentation/screens/commitment_screen.dart';
import '../../features/onboarding/presentation/screens/feedback_screen.dart';
import '../../features/onboarding/presentation/screens/first_lesson_screen.dart';
import '../../features/onboarding/presentation/screens/goal_selection_screen.dart';
import '../../features/onboarding/presentation/screens/name_input_screen.dart';
import '../../features/onboarding/presentation/screens/problem_awareness_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/streak_screen.dart';
import '../../features/onboarding/presentation/screens/summary_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/practice/presentation/screens/practice_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import 'route_names.dart';

CustomTransitionPage<void> _onboardingPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(0.06, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      final fadeAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOut);

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(position: offsetAnimation, child: child),
      );
    },
  );
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        redirect: (context, state) => '/onboarding/welcome',
      ),
      GoRoute(
        path: '/track',
        redirect: (context, state) => '/onboarding/name',
      ),
      GoRoute(
        path: '/onboarding',
        redirect: (context, state) {
          return state.uri.path == '/onboarding' ? '/onboarding/welcome' : null;
        },
        routes: [
          GoRoute(
            path: 'welcome',
            name: RouteNames.welcome,
            pageBuilder: (context, state) => _onboardingPage(state, const WelcomeScreen()),
          ),
          GoRoute(
            path: 'name',
            name: RouteNames.onboardingName,
            pageBuilder: (context, state) => _onboardingPage(state, const NameInputScreen()),
          ),
          GoRoute(
            path: 'goal',
            name: RouteNames.onboardingGoal,
            pageBuilder: (context, state) => _onboardingPage(state, const GoalSelectionScreen()),
          ),
          GoRoute(
            path: 'problem',
            name: RouteNames.onboardingProblem,
            pageBuilder: (context, state) => _onboardingPage(state, const ProblemAwarenessScreen()),
          ),
          GoRoute(
            path: 'aha',
            name: RouteNames.onboardingAha,
            pageBuilder: (context, state) => _onboardingPage(state, const AhaMomentScreen()),
          ),
          GoRoute(
            path: 'lesson',
            name: RouteNames.onboardingLesson,
            pageBuilder: (context, state) => _onboardingPage(state, const FirstLessonScreen()),
          ),
          GoRoute(
            path: 'feedback/:result',
            name: RouteNames.onboardingFeedback,
            pageBuilder: (context, state) {
              final result = state.pathParameters['result'];
              final isCorrect = result == 'correct';
              return _onboardingPage(state, FeedbackScreen(isCorrect: isCorrect));
            },
          ),
          GoRoute(
            path: 'celebration',
            name: RouteNames.onboardingCelebration,
            pageBuilder: (context, state) => _onboardingPage(state, const CelebrationScreen()),
          ),
          GoRoute(
            path: 'streak',
            name: RouteNames.onboardingStreak,
            pageBuilder: (context, state) => _onboardingPage(state, const StreakScreen()),
          ),
          GoRoute(
            path: 'commitment',
            name: RouteNames.onboardingCommitment,
            pageBuilder: (context, state) => _onboardingPage(state, const CommitmentScreen()),
          ),
          GoRoute(
            path: 'summary',
            name: RouteNames.onboardingSummary,
            pageBuilder: (context, state) => _onboardingPage(state, const SummaryScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/lesson/:lessonId',
        name: RouteNames.lesson,
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId'] ?? '';
          return LessonScreen(lessonId: lessonId);
        },
        routes: [
          GoRoute(
            path: 'detail',
            name: RouteNames.lessonDetail,
            builder: (context, state) {
              final lessonId = state.pathParameters['lessonId'] ?? '';
              return LessonDetailScreen(lessonId: lessonId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/practice',
        name: RouteNames.practice,
        builder: (context, state) => const PracticeScreen(),
      ),
      GoRoute(
        path: '/progress',
        name: RouteNames.progress,
        builder: (context, state) => const ProgressScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});
