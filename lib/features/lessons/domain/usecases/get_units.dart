import '../../../../core/usecases/usecase.dart';
import '../entities/unit.dart';
import '../repositories/lesson_repository.dart';

class GetUnits implements UseCase<List<Unit>, NoParams> {
  final LessonRepository repository;

  const GetUnits(this.repository);

  @override
  Future<List<Unit>> call(NoParams params) => repository.getUnits();
}

