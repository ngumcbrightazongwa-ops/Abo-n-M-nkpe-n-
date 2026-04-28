import '../entities/onboarding_profile.dart';

abstract class OnboardingRepository {
  Future<OnboardingProfile> getProfile();
  Future<void> saveProfile(OnboardingProfile profile);
}
