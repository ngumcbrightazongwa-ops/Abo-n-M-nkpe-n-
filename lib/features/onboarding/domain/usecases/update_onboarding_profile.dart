import '../../../../core/usecases/usecase.dart';
import '../entities/onboarding_profile.dart';
import '../repositories/onboarding_repository.dart';

class UpdateOnboardingProfileParams {
  final OnboardingProfile profile;

  const UpdateOnboardingProfileParams(this.profile);
}

class UpdateOnboardingProfile extends UseCase<void, UpdateOnboardingProfileParams> {
  final OnboardingRepository repository;

  UpdateOnboardingProfile(this.repository);

  @override
  Future<void> call(UpdateOnboardingProfileParams params) {
    return repository.saveProfile(params.profile);
  }
}
