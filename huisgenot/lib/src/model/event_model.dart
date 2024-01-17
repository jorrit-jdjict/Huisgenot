import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/house_model.dart';

class EventItem {
  final int eventId;
  final String imageUrl;
  final String eventTitle;
  final String eventDescription;
  final DateTime postDate;
  final String houseId;

  EventItem({
    required this.eventId,
    required this.imageUrl,
    required this.eventTitle,
    required this.eventDescription,
    required this.postDate,
    required this.houseId,
  });

  factory EventItem.fromMap(Map<String, dynamic> map) {
    return EventItem(
      eventId: map['eventId'],
      imageUrl: map['imageUrl'],
      eventTitle: map['eventTitle'],
      eventDescription: map['eventDescription'],
      postDate: DateTime.parse(map['postDate']),
      houseId: map['houseId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'imageUrl': imageUrl,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'postDate': postDate,
      'houseId': houseId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'imageUrl': imageUrl,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'postDate': postDate,
      'houseId': houseId,
    };
  }
  factory EventItem.fromDocument(DocumentSnapshot documentSnapshot) {
    int eventId = documentSnapshot.get('eventId');
    String imageUrl = documentSnapshot.get('imageUrl');
    String eventTitle = documentSnapshot.get('eventTitle');
    String eventDescription = documentSnapshot.get('eventDescription');
    DateTime postDate = documentSnapshot.get('postDate');
    String houseId = documentSnapshot.get('houseId');

    return EventItem(
        eventId: eventId,
        imageUrl: imageUrl,
        eventTitle: eventTitle,
        eventDescription: eventDescription,
        postDate: postDate,
        houseId: houseId,
    );
  }
}
