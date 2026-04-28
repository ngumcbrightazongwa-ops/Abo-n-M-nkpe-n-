class OnboardingProfile {
  final String name;
  final String goal;
  final String commitmentLevel;

  const OnboardingProfile({
    required this.name,
    required this.goal,
    required this.commitmentLevel,
  });

  static const empty = OnboardingProfile(name: '', goal: '', commitmentLevel: '');

  OnboardingProfile copyWith({
    String? name,
    String? goal,
    String? commitmentLevel,
  }) {
    return OnboardingProfile(
      name: name ?? this.name,
      goal: goal ?? this.goal,
      commitmentLevel: commitmentLevel ?? this.commitmentLevel,
    );
  }
}
