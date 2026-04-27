import '../../domain/entities/lesson.dart';
import '../../domain/entities/unit.dart';
import '../../domain/repositories/lesson_repository.dart';
import '../datasources/lesson_local_datasource.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonLocalDataSource localDataSource;

  const LessonRepositoryImpl(this.localDataSource);

  @override
  Future<List<Unit>> getUnits() async {
    final models = await localDataSource.getUnits();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Lesson>> getLessonsByUnit(String unitId) async {
    final models = await localDataSource.getLessonsByUnit(unitId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Lesson?> getLessonDetail(String lessonId) async {
    final model = await localDataSource.getLessonDetail(lessonId);
    return model?.toEntity();
  }
}

