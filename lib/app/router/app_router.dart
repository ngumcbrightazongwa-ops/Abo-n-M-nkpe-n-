import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/lessons/presentation/screens/lesson_detail_screen.dart';
import '../../features/lessons/presentation/screens/lesson_screen.dart';
import '../../features/onboarding/presentation/screens/learner_track_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/practice/presentation/screens/practice_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import 'route_names.dart';

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
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/track',
        name: RouteNames.learnerTrack,
        builder: (context, state) => const LearnerTrackScreen(),
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
