import 'exercise.dart';
import 'vocabulary_item.dart';

class Lesson {
  final String id;
  final String unitId;
  final String title;
  final String description;
  final List<VocabularyItem> vocabulary;
  final List<Exercise> exercises;

  const Lesson({
    required this.id,
    required this.unitId,
    required this.title,
    required this.description,
    required this.vocabulary,
    required this.exercises,
  });
}
