import 'package:flutter/material.dart';
import 'package:huisgenot/src/view/screens/chat_conversation_screen.dart';

class ChatOverviewScreen extends StatelessWidget {
  const ChatOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        leading: Container(
          margin: const EdgeInsets.all(8.0), // Add margin here
          child: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0), // Add margin here
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const HomeScreen()));
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with your actual chat list count
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    // Navigate to the ChatConversationScreen with user data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatConversationScreen(
                          userName:
                              'User Name', // Replace with actual user data
                          userProfileImage:
                              'assets/images/profile_img.png', // Replace with actual user data
                        ),
                      ),
                    );
                  },
                  title:
                      const Text('User Name'), // Replace with actual user data
                  subtitle: const Text(
                      'Last message goes here...'), // Replace with actual user data
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/profile_img.png'), // Replace with actual user data
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
