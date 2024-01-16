import 'package:huisgenot/src/model/house_model.dart';

class EventItem {
  final String id;
  final String imageUrl;
  final String eventTitle;
  final String eventDescription;
  final DateTime postDate;
  final House postAuthor;

  EventItem({
    required this.id,
    required this.imageUrl,
    required this.eventTitle,
    required this.eventDescription,
    required this.postDate,
    required this.postAuthor,
  });

  factory EventItem.fromMap(Map<String, dynamic> map) {
    return EventItem(
      id: map['id'],
      imageUrl: map['imageUrl'],
      eventTitle: map['eventTitle'],
      eventDescription: map['eventDescription'],
      postDate: DateTime.parse(map['postDate']),
      postAuthor: House.fromMap(map['postAuthor']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'postDate': postDate.toIso8601String(),
      'postAuthor': postAuthor.toMap(),
    };
  }
}
