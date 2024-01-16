import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/feed_model.dart';


class FeedController {
  final CollectionReference feedsCollection = FirebaseFirestore.instance.collection('feeds');

  Future<void> uploadFeed(FeedItem feed) async {
    try {
      await feedsCollection.add(feed.toMap());
    } catch (e) {
      print('Error uploading feed: $e');
    }
  }
}