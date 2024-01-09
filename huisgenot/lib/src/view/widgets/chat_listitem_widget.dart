import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_img.png'),
      ),
      title: const Text('Chat User Name'),
      subtitle: const Text('Last message goes here...'),
      onTap: () {
        // Handle chat item click here
        // You can navigate to the chat screen for this user or perform other actions.
      },
    );
  }
}
