import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  //! Firebase instance/object
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //! Login User
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    //* Attempt to login
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firebaseFirestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      //* If login is successful, return the user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: userDoc['name'],
      );

      return user;
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  //! Register User
  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    //* Attempt to singUp
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //* Create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      //* Sava user information
      await _firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      //* Return user
      return user;
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  //! Logout user
  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  //! GetCurrent user
  @override
  Future<AppUser?> getCurrentUser() async {
    //* get currently logged in user in Firebase
    final firebaseUser = _firebaseAuth.currentUser;

    //* no user logged in...
    if (firebaseUser == null) {
      return null;
    }

    DocumentSnapshot userDoc = await _firebaseFirestore
        .collection("users")
        .doc(firebaseUser.uid)
        .get();

    //* user exists...
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: userDoc['name'],
    );
  }
}
