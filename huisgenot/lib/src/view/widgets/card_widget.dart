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
      // ... existing code ...
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                // ... existing code for box decoration ...
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    feedItem.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Author: ${feedItem.postAuthor.name}'
                          .toUpperCase(), // Example of using FeedItem data
                      style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Text(
                      feedItem.postTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${feedItem.postDate.day} ${feedItem.postDate.month} - ${feedItem.postDate.hour}:${feedItem.postDate.minute}',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ... existing Positioned widget ...
        ],
      ),
    );
  }
}
