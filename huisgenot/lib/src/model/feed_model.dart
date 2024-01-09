import 'package:huisgenot/src/model/house_model.dart';

class FeedItem {
  final String id;
  final String imageUrl;
  final String postTitle;
  final DateTime postDate;
  final House postAuthor;

  FeedItem({
    required this.id,
    required this.imageUrl,
    required this.postTitle,
    required this.postDate,
    required this.postAuthor,
  });

  factory FeedItem.fromMap(Map<String, dynamic> map) {
    return FeedItem(
      id: map['id'],
      imageUrl: map['imageUrl'],
      postTitle: map['postTitle'],
      postDate: DateTime.parse(map['postDate']),
      postAuthor: House.fromMap(map['postAuthor']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'postTitle': postTitle,
      'postDate': postDate.toIso8601String(),
      'postAuthor': postAuthor.toMap(),
    };
  }
}
