import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/repos/profile_repo.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  // fetch user profile using repo
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchProfile(uid);

      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError('Failed to fetch profile: $e'));
    }
  }

  // update bio and profile picture
  Future<void> updateProfile({required String uid, String? newBio}) async {
    try {
      emit(ProfileLoading());

      final currentUser = await profileRepo.fetchProfile(uid);

      if (currentUser == null) {
        emit(ProfileError('Failed to fetch user for profile update'));
        return;
      }

      // Profile picture update

      // Update new profile
      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
      );

      // Update in repo
      await profileRepo.updateProfile(updatedProfile);

      // re-fetch updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError('Failed to update profile: $e'));
    }
  }
}
