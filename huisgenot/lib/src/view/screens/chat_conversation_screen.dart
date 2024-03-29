import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:huisgenot/src/controller/message_controller.dart';
import 'package:huisgenot/src/model/chat_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatConversationScreen extends StatefulWidget {
  final String chatId; // Vervang door daadwerkelijke gebruikersgegevens
  final String userProfileImage; // Vervang door daadwerkelijke gebruikersgegevens

  const ChatConversationScreen({
    Key? key,
    required this.chatId,
    required this.userProfileImage,
  }) : super(key: key);

  @override
  _ChatConversationScreenState createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _textController = TextEditingController();
  final MessageController _messageController = MessageController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.userProfileImage),
            ),
            SizedBox(width: 35.0),
            Text(
              widget.chatId,
              style: TextStyle(color: Colors.white),
            ),
          ],
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
              stream: _messageController.getChatMessages(widget.chatId, 20), // Vervang door de daadwerkelijke conversatie-ID
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Toon een laadindicator tijdens het ophalen van gegevens
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF426421),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      _sendMessage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessages message) {
    double maxWidth = MediaQuery.of(context).size.width * 0.9;

    return Align(
      alignment: message.userId == _prefs.getString('first_name') ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: message.userId == _prefs.getString('first_name')  ? Color(0xFF426421) : Color(0xFF6E7467),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.userId != _prefs.getString('first_name') )
              Text(
                message.userId,
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold ,color: Colors.white),
              ),
            Text(
              message.content,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            Text(
              _formatTimestamp(message.timestamp),
              style: const TextStyle(fontSize: 12.0, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    // Gebruik de intl-bibliotheek om het tijdstempel in het gewenste formaat weer te geven
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    String formattedTime = DateFormat.Hm().format(dateTime); // Uur:minuut:seconde-formaat
    return formattedTime;
  }

  void _sendMessage() {
    String messageContent = _textController.text.trim();
    if (messageContent.isNotEmpty) {
      String? senderUserId = _prefs.getString('first_name'); // Vervang door de daadwerkelijke gebruikers-ID's

      ChatMessages chatMessage = ChatMessages(
        userId: senderUserId!,
        chatId: widget.chatId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: messageContent,
      );

      _messageController.sendChatMessage(chatMessage);

      _textController.clear();
    }
  }
}
