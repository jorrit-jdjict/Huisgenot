import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/feed_model.dart';
import 'dart:developer';

class FeedController {
  final CollectionReference feedsCollection =
      FirebaseFirestore.instance.collection('feeds');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final collection = "feeds";

  Future<void> uploadFeed(FeedItem feed) async {
    try {
      await feedsCollection.add(feed.toMap());
    } catch (e) {
      print('Error uploading feed: $e');
    }
  }

  Stream<List<FeedItem>> getFeedItems() {
    return _firestore
        .collection(collection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        print('No feed items found.');
        return <FeedItem>[]; // Return an empty list if no documents are found
      } else {
        return querySnapshot.docs.map((doc) {
          print('Feed item found: ${doc.id}');
          return FeedItem.fromDocument(doc);
        }).toList();
      }
    });
  }
}
