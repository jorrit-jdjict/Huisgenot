import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_img.png'),
      ),
      title: Text('Chat User Name'),
      subtitle: Text('Last message goes here...'),
      onTap: () {
        // Handle chat item click here
        // You can navigate to the chat screen for this user or perform other actions.
      },
    );
  }
}
