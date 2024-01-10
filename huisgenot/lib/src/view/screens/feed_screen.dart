import 'package:flutter/material.dart';
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
          onTap: () {},
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
          // Handle the plus button tap
        },
        child: const Icon(Icons.add),
        backgroundColor: colorScheme.primary,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
