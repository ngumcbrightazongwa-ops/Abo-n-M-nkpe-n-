import '../../../../data_seed/nkwen_units_seed.dart';
import '../models/lesson_model.dart';
import '../models/unit_model.dart';

class LessonLocalDataSource {
  const LessonLocalDataSource();

  Future<List<UnitModel>> getUnits() async {
    return nkwenUnitsSeed;
  }

  Future<List<LessonModel>> getLessonsByUnit(String unitId) async {
    final matches = nkwenUnitsSeed.where((u) => u.id == unitId).toList();
    if (matches.isEmpty) return [];
    return matches.first.lessons;
  }

  Future<LessonModel?> getLessonDetail(String lessonId) async {
    for (final unit in nkwenUnitsSeed) {
      for (final lesson in unit.lessons) {
        if (lesson.id == lessonId) return lesson;
      }
    }
    return null;
  }
}
