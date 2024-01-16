import 'package:flutter/material.dart';
import 'package:huisgenot/src/view/screens/create_feed_or_event_screen.dart';
import 'package:huisgenot/src/view/screens/house_screen.dart';
import '../widgets/card_widget.dart';
import 'package:huisgenot/src/view/screens/chat_overview_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Huisgenot'),
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
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_img.png'),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatOverviewScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            child: const Row(
              children: [
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const CardWidget();
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
        child: const Icon(Icons.add), // Plus icon
        backgroundColor:
            Theme.of(context).primaryColor, // Use your primary color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Position it at the bottom right corner
    );
  }
}
