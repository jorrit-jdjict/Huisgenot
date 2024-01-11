import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:huisgenot/src/controller/chat_controller.dart';
import 'package:huisgenot/src/model/chat_messages.dart';

class ChatConversationScreen extends StatefulWidget {
  final String userName; // Vervang door daadwerkelijke gebruikersgegevens
  final String userProfileImage; // Vervang door daadwerkelijke gebruikersgegevens

  const ChatConversationScreen({
    Key? key,
    required this.userName,
    required this.userProfileImage,
  }) : super(key: key);

  @override
  _ChatConversationScreenState createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _textController = TextEditingController();
  final ChatController _chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Navigeer terug naar het ChatScreen
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(widget.userProfileImage),
            ),
          ),
        ),
        actions: const [
          // Voeg eventuele aanvullende acties toe die je nodig hebt voor het chatscherm
        ],
      ),
      body: Column(
        children: [
          // Chat-inhoud komt hier (vervang dit deel door je werkelijke chat-inhoud)
          Expanded(
            child: StreamBuilder<List<ChatMessages>>(
              stream: _chatController.getChatMessages('senderUserId-recipientUserId', 20), // Vervang door de daadwerkelijke conversatie-ID
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Toon een laadindicator tijdens het ophalen van gegevens
                } else if (snapshot.hasError) {
                  return Text('Fout: ${snapshot.error}');
                } else {
                  // Toon de chatberichten
                  List<ChatMessages> messages = snapshot.data ?? [];
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      ChatMessages message = messages[index];
                      return _buildMessage(message);
                    },
                  );
                }
              },
            ),
          ),
          // Invoerveld voor het verzenden van berichten
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Roep de methode aan om het bericht te verzenden wanneer de verzendknop wordt ingedrukt
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessages message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: message.idFrom == 'senderUserId' ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.idFrom == 'senderUserId'
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(
                _formatTimestamp(message.timestamp),
                style: TextStyle(fontSize: 12.0, color: Colors.white70),
              ),
            ],
          ),
          Text(
            message.content,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    // Gebruik de intl-bibliotheek om het tijdstempel in het gewenste formaat weer te geven
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    String formattedTime = DateFormat.Hms().format(dateTime); // Uur:minuut:seconde-formaat
    return formattedTime;
  }

  void _sendMessage() {
    String messageContent = _textController.text.trim();
    if (messageContent.isNotEmpty) {
      String senderUserId = 'senderUserId'; // Vervang door de daadwerkelijke gebruikers-ID's
      String recipientUserId = 'recipientUserId'; // Vervang door de daadwerkelijke gebruikers-ID's

      ChatMessages chatMessage = ChatMessages(
        idFrom: senderUserId,
        idTo: recipientUserId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: messageContent,
      );

      String conversationId = '$senderUserId-$recipientUserId';

      _chatController.sendChatMessage(chatMessage, conversationId);

      _textController.clear();
    }
  }
}
