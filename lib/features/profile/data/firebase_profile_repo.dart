import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_app/features/profile/domain/repos/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchProfile(String uid) async {
    try {
      // Fetch profile from firebase
      final userDoc =
          await _firebaseFirestore.collection("users").doc(uid).get();

      log(userDoc.toString());

      if (userDoc.exists) {
        final userData = userDoc.data();

        log(userData.toString());

        // Convert json to ProfileUser
        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'],
            profileImageUrl: userData['profileImageUrl'].toString(),
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) {
    try {
      // Update profile in firebase
      return _firebaseFirestore
          .collection("users")
          .doc(updateProfile.uid)
          .update({
        'bio': updateProfile.bio,
        'profileImageUrl': updateProfile.profileImageUrl,
      });
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
