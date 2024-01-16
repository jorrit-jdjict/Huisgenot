import 'dart:developer';

import 'package:flutter/material.dart';
// Widgets
import '../widgets/card_widget.dart';
import '../widgets/ad_widget.dart';
// Models
import 'package:huisgenot/src/model/feed_model.dart';
// Views
import 'package:huisgenot/src/view/screens/chat_overview_screen.dart';
import 'package:huisgenot/src/view/screens/house_screen.dart';
import 'package:huisgenot/src/view/screens/create_feed_or_event_screen.dart';
// Controllers
import 'package:huisgenot/src/controller/feed_controller.dart';

class FeedScreen extends StatelessWidget {
  final FeedController _feedController = FeedController();

  FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _feedController.getFeedItems();
    });

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.transparent, // Add your desired color here
              ],
              stops: [0, 1], // Adjust the stops as needed
            ),
          ),
        ),
        title: const Text(
          'Huisgenot',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatOverviewScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: 48.0, // Set the same size for the icon
              height: 48.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            // Navigate to the CreateFeedScreen when FloatingActionButton is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HouseScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            width: 48.0, // Set the same size for the image
            height: 48.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile_img.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 8),
            child: const Row(
              children: [
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<FeedItem>>(
              stream: _feedController.getFeedItems(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var feedItems = snapshot.data!;

                  // Calculate the total count including ads
                  int totalCount =
                      feedItems.length + (feedItems.length / 4).floor();

                  return ListView.builder(
                    itemCount: totalCount,
                    itemBuilder: (BuildContext context, int index) {
                      // Determine if the current index is an ad position
                      if (index % 5 == 4) {
                        // Return an ad widget
                        return const AdWidget(); // Replace with your actual Ad Widget
                      } else {
                        // Adjust index for feed item
                        int itemIndex = index - (index / 5).floor();
                        return CardWidget(feedItem: feedItems[itemIndex]);
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  inspect(snapshot.error); // Inspect the error
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CreateFeedScreen when FloatingActionButton is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateFeedOrEventScreen(),
            ),
          );
        },
        backgroundColor: colorScheme.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
