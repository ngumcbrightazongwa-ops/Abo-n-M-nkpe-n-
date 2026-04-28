import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/local_storage_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/entities/onboarding_profile.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../../domain/usecases/get_onboarding_profile.dart';
import '../../domain/usecases/update_onboarding_profile.dart';

class OnboardingState {
  final OnboardingProfile profile;

  const OnboardingState({required this.profile});

  OnboardingState copyWith({OnboardingProfile? profile}) {
    return OnboardingState(profile: profile ?? this.profile);
  }
}

final onboardingLocalStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepositoryImpl(ref.read(onboardingLocalStorageProvider));
});

final getOnboardingProfileProvider = Provider<GetOnboardingProfile>((ref) {
  return GetOnboardingProfile(ref.read(onboardingRepositoryProvider));
});

final updateOnboardingProfileProvider = Provider<UpdateOnboardingProfile>((ref) {
  return UpdateOnboardingProfile(ref.read(onboardingRepositoryProvider));
});

final onboardingControllerProvider = StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  return OnboardingController(
    getProfile: ref.read(getOnboardingProfileProvider),
    updateProfile: ref.read(updateOnboardingProfileProvider),
  );
});

class OnboardingController extends StateNotifier<OnboardingState> {
  final GetOnboardingProfile getProfile;
  final UpdateOnboardingProfile updateProfile;

  OnboardingController({
    required this.getProfile,
    required this.updateProfile,
  }) : super(const OnboardingState(profile: OnboardingProfile.empty)) {
    _load();
  }

  Future<void> _load() async {
    final profile = await getProfile(const NoParams());
    state = state.copyWith(profile: profile);
  }

  Future<void> setName(String name) async {
    final next = state.profile.copyWith(name: name.trim());
    state = state.copyWith(profile: next);
    await updateProfile(UpdateOnboardingProfileParams(next));
  }

  Future<void> setGoal(String goal) async {
    final next = state.profile.copyWith(goal: goal);
    state = state.copyWith(profile: next);
    await updateProfile(UpdateOnboardingProfileParams(next));
  }

  Future<void> setCommitmentLevel(String commitmentLevel) async {
    final next = state.profile.copyWith(commitmentLevel: commitmentLevel);
    state = state.copyWith(profile: next);
    await updateProfile(UpdateOnboardingProfileParams(next));
  }

  Future<void> reset() async {
    state = const OnboardingState(profile: OnboardingProfile.empty);
    await updateProfile(const UpdateOnboardingProfileParams(OnboardingProfile.empty));
  }
}
