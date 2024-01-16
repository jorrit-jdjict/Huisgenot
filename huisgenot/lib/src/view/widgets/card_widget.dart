import 'package:flutter/material.dart';
import 'package:huisgenot/src/model/feed_model.dart';

class CardWidget extends StatelessWidget {
  final FeedItem feedItem;

  const CardWidget({Key? key, required this.feedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(10, 0, 12, 12),
      color:
          Colors.transparent, // Set the card's background color to transparent
      elevation: 0, // Add elevation for a soft shadow
      shadowColor:
          Colors.black.withOpacity(0.2), // Set shadow color with opacity
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    feedItem.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Auteur: ${feedItem.postAuthor.name}'
                          .toUpperCase(), // Example of using FeedItem data
                      style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feedItem.postTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${feedItem.postDate.day}/${feedItem.postDate.month}/${feedItem.postDate.year} @ ${feedItem.postDate.hour}:${feedItem.postDate.minute}',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 0,
            child: RawMaterialButton(
              onPressed: () {
                // Handle button tap
              },
              shape: CircleBorder(),
              elevation: 0,
              fillColor: colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
