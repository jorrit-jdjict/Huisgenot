import 'package:flutter/material.dart';

class ChatConversationScreen extends StatelessWidget {
  final String userName; // Replace with actual user data
  final String userProfileImage; // Replace with actual user data

  const ChatConversationScreen({
    Key? key,
    required this.userName,
    required this.userProfileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Navigate back to the ChatScreen
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(userProfileImage),
            ),
          ),
        ),
        actions: [
          // Add any additional actions you need for the chat screen here
        ],
      ),
      body: const Center(
        child:
            Text('Chat content goes here'), // Replace with actual chat content
      ),
    );
  }
}
