import '../entities/lesson.dart';
import '../entities/unit.dart';

abstract class LessonRepository {
  Future<List<Unit>> getUnits();
  Future<List<Lesson>> getLessonsByUnit(String unitId);
  Future<Lesson?> getLessonDetail(String lessonId);
}
