import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/event_model.dart';

class EventController {
  final CollectionReference feedsCollection = FirebaseFirestore.instance.collection('events');

  Future<void> uploadFeed(EventItem event) async {
    try {
      await feedsCollection.add(event.toMap());
    } catch (e) {
      print('Error uploading feed: $e');
    }
  }
}