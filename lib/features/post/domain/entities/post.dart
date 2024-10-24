import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final String imageUrl;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.imageUrl,
    required this.createdAt,
  });

  Post copy({String? imageUrl, String? text}) {
    return Post(
      id: id,
      userId: userId,
      userName: userName,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt,
    );
  }

  // convert post -> json format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'text': text,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // convert json -> post format
  factory Post.fromJson(Map<String, dynamic> jsonPost) {
    return Post(
      id: jsonPost['id'],
      userId: jsonPost['userId'],
      userName: jsonPost['userName'],
      text: jsonPost['text'],
      imageUrl: jsonPost['imageUrl'],
      createdAt: (jsonPost['createdAt'] as Timestamp).toDate(),
    );
  }
}
