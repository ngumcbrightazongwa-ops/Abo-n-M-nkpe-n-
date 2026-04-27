import '../features/lessons/data/models/exercise_model.dart';
import '../features/lessons/data/models/lesson_model.dart';
import '../features/lessons/data/models/vocabulary_model.dart';

const String unitGreetingsId = 'unit_greetings';
const String lessonGreetings1Id = 'greetings_1';

const LessonModel greetingsLesson1Seed = LessonModel(
  id: lessonGreetings1Id,
  unitId: unitGreetingsId,
  title: 'Good morning',
  description: 'Learn a friendly morning greeting in Nkwen.',
  vocabulary: [
    VocabularyModel(
      word: 'Ǹjwelǎ',
      pronunciation: 'n-jweh-la',
      meaning: 'Good morning',
      category: 'Greetings',
    ),
  ],
  exercises: [
    ExerciseModel(
      id: 'ex_1',
      type: 'multiple_choice',
      prompt: 'What does “Ǹjwelǎ” mean?',
      options: ['Good morning', 'Good night', 'Thank you'],
      answer: 'Good morning',
    ),
  ],
);

