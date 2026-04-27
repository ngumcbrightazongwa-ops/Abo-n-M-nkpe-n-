import '../../domain/entities/vocabulary_item.dart';

class VocabularyModel {
  final String word;
  final String pronunciation;
  final String meaning;
  final String category;

  const VocabularyModel({
    required this.word,
    required this.pronunciation,
    required this.meaning,
    required this.category,
  });

  VocabularyItem toEntity() {
    return VocabularyItem(
      word: word,
      pronunciation: pronunciation,
      meaning: meaning,
      category: category,
    );
  }
}
