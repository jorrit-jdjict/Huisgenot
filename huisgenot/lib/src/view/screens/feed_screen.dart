import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:huisgenot/src/model/feed_model.dart';
import 'package:huisgenot/src/view/screens/create_feed_or_event_screen.dart';
import 'package:huisgenot/src/view/screens/house_screen.dart';
import '../widgets/card_widget.dart';
import 'package:huisgenot/src/view/screens/chat_overview_screen.dart';
import 'package:huisgenot/src/controller/feed_controller.dart';

class FeedScreen extends StatelessWidget {
  final FeedController _feedController = FeedController();

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
          decoration: BoxDecoration(
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
        title: Text(
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
              child: Icon(
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
            decoration: BoxDecoration(
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
            padding: EdgeInsets.only(top: 8),
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
                  inspect(feedItems); // Inspect the entire list
                  return ListView.builder(
                    itemCount: feedItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardWidget(feedItem: feedItems[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  inspect(snapshot.error); // Inspect the error
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(child: CircularProgressIndicator());
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
        child: const Icon(Icons.add),
        backgroundColor: colorScheme.primary,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
