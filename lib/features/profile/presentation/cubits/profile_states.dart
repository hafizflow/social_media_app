import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';

abstract class ProfileStates {}

// initial state
class ProfileInitial extends ProfileStates {}

// loading state
class ProfileLoading extends ProfileStates {}

// loaded state
class ProfileLoaded extends ProfileStates {
  final ProfileUser profileUser;
  ProfileLoaded(this.profileUser);
}

// error state
class ProfileError extends ProfileStates {
  final String message;
  ProfileError(this.message);
}
