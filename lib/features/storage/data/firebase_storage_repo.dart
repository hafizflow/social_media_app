import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadBytes(fileBytes, fileName, "profile_images");
  }

  //! Helper methods to uploads files in storage

  // mobile platform (file)
  Future<String?> _uploadFile(
      String path, String fileName, String folder) async {
    try {
      // get file
      final file = File(path);

      // find place to store
      final storageRef = storage.ref().child("$folder/$fileName");

      // upload file
      final uploadTask = await storageRef.putFile(file);

      // get image download url
      final getDownloadUrl = await uploadTask.ref.getDownloadURL();

      return getDownloadUrl;
    } catch (e) {}
    return null;
  }

  // web platform (bytes)
  Future<String?> _uploadBytes(
      Uint8List fileBytes, String fileName, String folder) async {
    try {
      // find place to store
      final storageRef = storage.ref().child("$folder/$fileName");

      // upload file
      final uploadTask = await storageRef.putData(fileBytes);

      // get image download url
      final getDownloadUrl = await uploadTask.ref.getDownloadURL();

      return getDownloadUrl;
    } catch (e) {}
    return null;
  }
}
