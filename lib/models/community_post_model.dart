import 'package:flutter/foundation.dart';

@immutable
class CommunityPost {
  final int? id;
  final String userId;
  final String content;
  final int likes;
  final DateTime timestamp;

  const CommunityPost({
    this.id,
    required this.userId,
    required this.content,
    this.likes = 0,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'likes': likes,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CommunityPost.fromMap(Map<String, dynamic> map) {
    return CommunityPost(
      id: map['id'],
      userId: map['user_id'],
      content: map['content'],
      likes: map['likes'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
