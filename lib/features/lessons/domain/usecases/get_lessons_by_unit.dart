import '../../../../core/usecases/usecase.dart';
import '../entities/lesson.dart';
import '../repositories/lesson_repository.dart';

class GetLessonsByUnit implements UseCase<List<Lesson>, String> {
  final LessonRepository repository;

  const GetLessonsByUnit(this.repository);

  @override
  Future<List<Lesson>> call(String params) => repository.getLessonsByUnit(params);
}

