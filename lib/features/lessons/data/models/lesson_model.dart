import '../../domain/entities/lesson.dart';
import 'exercise_model.dart';
import 'vocabulary_model.dart';

class LessonModel {
  final String id;
  final String unitId;
  final String title;
  final String description;
  final List<VocabularyModel> vocabulary;
  final List<ExerciseModel> exercises;

  const LessonModel({
    required this.id,
    required this.unitId,
    required this.title,
    required this.description,
    required this.vocabulary,
    required this.exercises,
  });

  Lesson toEntity() {
    return Lesson(
      id: id,
      unitId: unitId,
      title: title,
      description: description,
      vocabulary: vocabulary.map((v) => v.toEntity()).toList(),
      exercises: exercises.map((e) => e.toEntity()).toList(),
    );
  }
}
