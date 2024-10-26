import 'dart:typed_data';

abstract class StorageRepo {
  // Upload profile image in mobile device
  Future<String?> uploadProfileImageMobile(String path, String postId);

  // Upload profile image in web
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String postId);

  // Upload post image in mobile device
  Future<String?> uploadPostImageMobile(String path, String postId);

  // Upload post image in web
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String postId);
}
