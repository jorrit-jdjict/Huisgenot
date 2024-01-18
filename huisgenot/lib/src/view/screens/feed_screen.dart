// feed_screen.dart

import 'dart:developer';

import 'package:flutter/material.dart';
import '../widgets/card_widget.dart';
import '../widgets/ad_widget.dart';
import 'package:huisgenot/src/model/feed_model.dart';
import 'package:huisgenot/src/view/screens/chat_overview_screen.dart';
import 'package:huisgenot/src/view/screens/house_screen.dart';
import 'package:huisgenot/src/view/screens/create_feed_or_event_screen.dart';
import 'package:huisgenot/src/controller/feed_controller.dart';
import '../widgets/bottom_navigation.dart';

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
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              stops: [0, 1],
            ),
          ),
        ),
        title: const Text(
          'Huisgenot',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatOverviewScreen(),
                ),
              );
            },
            icon: Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
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
      bottomNavigationBar: CustomBottomNavigation(
        onHomePressed: () {},
        onAddPressed: () {
          // Image knop gaat naar HouseScreen
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CreateFeedOrEventScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        },
        onProfilePressed: () {
          // Image knop gaat naar HouseScreen
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HouseScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        },
      ),
    );
  }
}
