import 'package:flutter/material.dart';
import '../widgets/card_widget.dart';
import 'package:huisgenot/src/view/screens/chat_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huisgenot'),
        leading: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(8.0), // Add margin here
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/profile_img.png'), // Replace with your profile image
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0), // Add margin here
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatOverviewScreen()));
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16), // Remove 'const' here
            child: const Row(
              children: [
                Spacer(), // Spacing between profile image and chat button
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with your actual card count
              itemBuilder: (BuildContext context, int index) {
                return const CardWidget(); // Custom card widget
              },
            ),
          ),
        ],
      ),
    );
  }
}
