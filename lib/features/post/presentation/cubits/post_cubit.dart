import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';
import 'package:social_media_app/features/post/domain/repos/post_repo.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_states.dart';
import 'package:social_media_app/features/storage/domain/storage_repo.dart';

class PostCubit extends Cubit<PostStates> {
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  PostCubit({
    required this.postRepo,
    required this.storageRepo,
  }) : super(PostsInitial());

  // crate new post
  Future<void> createPost(
    Post post, {
    String? imagePath,
    Uint8List? bytes,
  }) async {
    String? imageUrl;

    try {
      // handle image upload for mobile platforms (using file path)
      if (imagePath != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadPostImageMobile(imagePath, post.id);
      }

      // handle image upload for web platforms (using bytes)
      else if (bytes != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadPostImageWeb(bytes, post.id);
      }

      // give imageUrl to post
      final newPost = post.copy(imageUrl: imageUrl);

      // create post in the backend
      postRepo.createPost(newPost);

      // fetch all post
      fetchAllPost();
    } catch (e) {
      emit(PostsError("Failed to create post ${e.toString()}"));
    }
  }

  // fetch all post
  Future<void> fetchAllPost() async {
    try {
      emit(PostsLoading());
      final allPosts = await postRepo.fetchAllPost();
      emit(PostsLoaded(allPosts));
    } catch (e) {
      emit(PostsError("Failed to fetch all post ${e.toString()}"));
    }
  }

  // delete a post
  Future<void> deletePost(String postId) async {
    try {
      await postRepo.deletePost(postId);
    } catch (e) {
      emit(PostsError("Failed to delete post ${e.toString()}"));
    }
  }
}
