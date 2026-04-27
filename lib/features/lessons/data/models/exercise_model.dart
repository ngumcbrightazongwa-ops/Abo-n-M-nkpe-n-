import '../../domain/entities/exercise.dart';

class ExerciseModel {
  final String id;
  final String type;
  final String prompt;
  final List<String> options;
  final String? answer;

  const ExerciseModel({
    required this.id,
    required this.type,
    required this.prompt,
    required this.options,
    this.answer,
  });

  Exercise toEntity() {
    return Exercise(
      id: id,
      type: type,
      prompt: prompt,
      options: options,
      answer: answer,
    );
  }
}
