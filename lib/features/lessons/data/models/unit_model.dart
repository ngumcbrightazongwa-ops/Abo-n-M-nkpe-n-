import '../../domain/entities/unit.dart';
import 'lesson_model.dart';

class UnitModel {
  final String id;
  final String title;
  final String description;
  final int order;
  final List<LessonModel> lessons;

  const UnitModel({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.lessons,
  });

  Unit toEntity() {
    return Unit(
      id: id,
      title: title,
      description: description,
      order: order,
      lessons: lessons.map((l) => l.toEntity()).toList(),
    );
  }
}
