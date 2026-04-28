import '../../../../core/usecases/usecase.dart';
import '../entities/onboarding_profile.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingProfile extends UseCase<OnboardingProfile, NoParams> {
  final OnboardingRepository repository;

  GetOnboardingProfile(this.repository);

  @override
  Future<OnboardingProfile> call(NoParams params) {
    return repository.getProfile();
  }
}
