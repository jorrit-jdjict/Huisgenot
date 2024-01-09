import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/feed_model.dart';

Future<void> addFeedItem(FeedItem feedItem) async {
  final CollectionReference feedCollection =
      FirebaseFirestore.instance.collection('feed');

  await feedCollection.add(feedItem.toMap());
}
