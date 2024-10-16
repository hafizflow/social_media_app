import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  //! Firebase instance/object
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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

      //* If login is successful, return the user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
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
    //* all currently logged in user in Firebase
    final firebaseUser = _firebaseAuth.currentUser;

    //* no user logged in...
    if (firebaseUser == null) {
      return null;
    }

    //* user exists...
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: '',
    );
  }
}
