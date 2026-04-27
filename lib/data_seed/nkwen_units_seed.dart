import '../features/lessons/data/models/unit_model.dart';
import 'nkwen_greetings_seed.dart';

const UnitModel unit1GreetingsSeed = UnitModel(
  id: unitGreetingsId,
  title: 'Greetings',
  description: 'Say hello and greet people politely.',
  order: 1,
  lessons: [greetingsLesson1Seed],
);

const List<UnitModel> nkwenUnitsSeed = [unit1GreetingsSeed];

