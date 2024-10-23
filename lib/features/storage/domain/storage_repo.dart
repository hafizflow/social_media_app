import 'dart:typed_data';

abstract class StorageRepo {
  // Upload profile image in mobile device
  Future<String?> uploadProfileImageMobile(String path, String fileName);

  // Upload profile image in web
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);
}
