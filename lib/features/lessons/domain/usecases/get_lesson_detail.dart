import '../../../../core/usecases/usecase.dart';
import '../entities/lesson.dart';
import '../repositories/lesson_repository.dart';

class GetLessonDetail implements UseCase<Lesson?, String> {
  final LessonRepository repository;

  const GetLessonDetail(this.repository);

  @override
  Future<Lesson?> call(String params) => repository.getLessonDetail(params);
}

