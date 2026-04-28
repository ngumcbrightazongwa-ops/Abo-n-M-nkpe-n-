import '../../domain/entities/onboarding_profile.dart';

class OnboardingProfileModel {
  final String name;
  final String goal;
  final String commitmentLevel;

  const OnboardingProfileModel({
    required this.name,
    required this.goal,
    required this.commitmentLevel,
  });

  factory OnboardingProfileModel.fromEntity(OnboardingProfile entity) {
    return OnboardingProfileModel(
      name: entity.name,
      goal: entity.goal,
      commitmentLevel: entity.commitmentLevel,
    );
  }

  OnboardingProfile toEntity() {
    return OnboardingProfile(
      name: name,
      goal: goal,
      commitmentLevel: commitmentLevel,
    );
  }

  factory OnboardingProfileModel.fromMap(Map<String, Object?> map) {
    return OnboardingProfileModel(
      name: (map['name'] as String?) ?? '',
      goal: (map['goal'] as String?) ?? '',
      commitmentLevel: (map['commitmentLevel'] as String?) ?? '',
    );
  }

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'goal': goal,
      'commitmentLevel': commitmentLevel,
    };
  }
}
