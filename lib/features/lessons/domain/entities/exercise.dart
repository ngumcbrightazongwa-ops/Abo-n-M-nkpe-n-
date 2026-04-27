class Exercise {
  final String id;
  final String type;
  final String prompt;
  final List<String> options;
  final String? answer;

  const Exercise({
    required this.id,
    required this.type,
    required this.prompt,
    required this.options,
    this.answer,
  });
}
