import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/feed_model.dart';

class FeedController {
  final CollectionReference feedsCollection =
      FirebaseFirestore.instance.collection('feeds');
  final collection = "feed";

  Future<void> uploadFeed(FeedItem feed) async {
    try {
      await feedsCollection.add(feed.toMap());
    } catch (e) {
      print('Error uploading feed: $e');
    }
  }

  Stream<List<FeedItem>> getFeedItems() {
    return feedsCollection
        .orderBy('postDate', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return FeedItem.fromDocument(doc);
      }).toList();
    });
  }
}
