import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/event_model.dart';

class EventController {
  final CollectionReference eventsCollection =
  FirebaseFirestore.instance.collection('events');

  // Function to upload an event to Firestore
  Future<void> uploadEvent(EventItem eventItem) async {
    try {
      await eventsCollection.add(eventItem.toJson());
    } catch (e) {
      print('Error uploading event: $e');
    }
  }

  // Function to get a stream of events from Firestore
  Stream<List<EventItem>> getEventsStream() {
    return eventsCollection.snapshots().map(
          (querySnapshot) {
        return querySnapshot.docs.map(
              (doc) {
            return EventItem.fromDocument(doc);
          },
        ).toList();
      },
    );
  }
}
