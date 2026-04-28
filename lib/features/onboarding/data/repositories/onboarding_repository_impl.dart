import '../../../../core/storage/local_storage_service.dart';
import '../../domain/entities/onboarding_profile.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../models/onboarding_profile_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  static const _profileKey = 'onboarding_profile';

  final LocalStorageService localStorage;

  OnboardingRepositoryImpl(this.localStorage);

  @override
  Future<OnboardingProfile> getProfile() async {
    final map = localStorage.get<Map<String, Object?>>(_profileKey);
    if (map == null) return OnboardingProfile.empty;
    return OnboardingProfileModel.fromMap(map).toEntity();
  }

  @override
  Future<void> saveProfile(OnboardingProfile profile) async {
    final model = OnboardingProfileModel.fromEntity(profile);
    await localStorage.set<Map<String, Object?>>(_profileKey, model.toMap());
  }
}
