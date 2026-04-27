import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/lesson_local_datasource.dart';
import '../data/repositories/lesson_repository_impl.dart';
import '../domain/entities/lesson.dart';
import '../domain/entities/unit.dart';
import '../domain/repositories/lesson_repository.dart';
import '../domain/usecases/get_lesson_detail.dart';
import '../domain/usecases/get_lessons_by_unit.dart';
import '../domain/usecases/get_units.dart';
import '../../../core/usecases/usecase.dart';

final lessonLocalDataSourceProvider = Provider<LessonLocalDataSource>((ref) {
  return const LessonLocalDataSource();
});

final lessonRepositoryProvider = Provider<LessonRepository>((ref) {
  final ds = ref.watch(lessonLocalDataSourceProvider);
  return LessonRepositoryImpl(ds);
});

final getUnitsProvider = Provider<GetUnits>((ref) {
  final repo = ref.watch(lessonRepositoryProvider);
  return GetUnits(repo);
});

final unitsProvider = FutureProvider<List<Unit>>((ref) async {
  final usecase = ref.watch(getUnitsProvider);
  return usecase(const NoParams());
});

final getLessonsByUnitProvider = Provider<GetLessonsByUnit>((ref) {
  final repo = ref.watch(lessonRepositoryProvider);
  return GetLessonsByUnit(repo);
});

final lessonsByUnitProvider = FutureProvider.family<List<Lesson>, String>((ref, unitId) async {
  final usecase = ref.watch(getLessonsByUnitProvider);
  return usecase(unitId);
});

final getLessonDetailProvider = Provider<GetLessonDetail>((ref) {
  final repo = ref.watch(lessonRepositoryProvider);
  return GetLessonDetail(repo);
});

final lessonDetailProvider = FutureProvider.family<Lesson?, String>((ref, lessonId) async {
  final usecase = ref.watch(getLessonDetailProvider);
  return usecase(lessonId);
});

