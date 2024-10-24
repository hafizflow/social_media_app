import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';
import 'package:social_media_app/features/post/domain/repos/post_repo.dart';

class FirebasePostRepo implements PostRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // store the post in a collection called posts
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> createPost(Post post) async {
    try {
      await postCollection.doc(post.id).set(post.toJson());
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postCollection.doc(postId).delete();
  }

  @override
  Future<List<Post>> fetchAllPost() async {
    try {
      // get all the post with most recent first
      final postSnapshot =
          await postCollection.orderBy('createdAt', descending: true).get();

      // convert each firestore document from json -> list of post
      final List<Post> allPosts = postSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return allPosts;
    } catch (e) {
      throw Exception('Error fetching all post: $e');
    }
  }

  @override
  Future<List<Post>> fetchPostByUserId(String userId) async {
    try {
      // get all the post from a specific user
      final postSnapshot =
          await postCollection.where('userId', isEqualTo: userId).get();

      // convert each firestore document from json -> list of post
      final List<Post> userPost = postSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return userPost;
    } catch (e) {
      throw Exception('Error fetching post by user id: $e');
    }
  }
}
