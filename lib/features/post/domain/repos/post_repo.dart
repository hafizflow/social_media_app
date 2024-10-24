import 'package:social_media_app/features/post/domain/entities/post.dart';

abstract class PostRepo {
  Future<List<Post>> fetchAllPost();
  Future<void> createPost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> fetchPostByUserId(String userId);
  // Future<void> updatePost(Post post);
}
