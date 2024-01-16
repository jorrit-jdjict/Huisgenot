import 'package:huisgenot/src/model/house_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory FeedItem.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.id;
    String imageUrl = 'assets/images/card_image.png';
    String postTitle = documentSnapshot.get('postTitle');
    DateTime postDate = DateTime.parse(documentSnapshot.get('postDate'));
    Map<String, dynamic> postAuthorMap = documentSnapshot.get('postAuthor');
    House postAuthor = House.fromMap(postAuthorMap);

    return FeedItem(
        id: id,
        imageUrl: imageUrl,
        postTitle: postTitle,
        postDate: postDate,
        postAuthor: postAuthor);
  }
}
