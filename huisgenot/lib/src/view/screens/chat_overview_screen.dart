import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/house_controller.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/chat_model.dart';

import 'package:huisgenot/src/view/screens/chat_conversation_screen.dart';

import '../../controller/chat_controller.dart';
import '../../model/house_model.dart';
import '../../model/user_model.dart';
import 'house_map_screen.dart';

class ChatOverviewScreen extends StatefulWidget {
  const ChatOverviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChatOverviewScreenState createState() => _ChatOverviewScreenState();
}

class _ChatOverviewScreenState extends State<ChatOverviewScreen> {

  final ChatController _chatController = ChatController();
  final UserController _userController = UserController();
  final HouseController _houseController = HouseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats', style: const TextStyle(color: Color(0xFFF7F7F7)) ),
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.all(8.0), // Add margin here
          child: IconButton(
            icon: const Icon(Icons.chevron_left,color: Color(0xFFF7F7F7)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0), // Add margin here
            child: IconButton(
              icon: const Icon(Icons.search, color: Color(0xFFF7F7F7)),
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
          Expanded(
            child: StreamBuilder<List<User>>(
              stream: _userController.getUsers(),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Toon een laadindicator tijdens het ophalen van gegevens
                } else if (snapshot1.hasError) {
                  return Text('Fout: ${snapshot1.error}');
                } else {

                  // Get house_id of current user
                  String userHouseId = "";
                  for (var user in snapshot1.data!) {
                    if (user.id == "7sZXYmgI4KM5UoItkr1l") { // TODO: Replace user ID with global variable or something
                      userHouseId = user.houseId;
                      break;
                    }
                  }

                  return StreamBuilder<List<Chat>>(
                    stream: _chatController.getChats(),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Toon een laadindicator tijdens het ophalen van gegevens
                      } else if (snapshot2.hasError) {
                        return Text('Fout: ${snapshot2.error}');
                      } else {

                        // Get chats that have house ID of user as member
                        List<Chat?> chats = [];
                        for (var chat in snapshot2.data!) {
                          if (
                            chat.houseId1 == userHouseId ||
                            chat.houseId2 == userHouseId
                          ) {
                            chats.add(chat);
                          }
                        }

                        return ListView.builder(
                          itemCount: chats.length,
                          itemBuilder: (BuildContext context, int index) {

                            return StreamBuilder<List<House>>(
                              stream: _houseController.getHouses(),
                              builder: (context, snapshot3) {
                                if (snapshot3.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator(); // Toon een laadindicator tijdens het ophalen van gegevens
                                } else if (snapshot3.hasError) {
                                  return Text('Fout: ${snapshot3.error}');
                                } else {

                                  // Get name of house 1
                                  String houseName1 = "";
                                  for (var house in snapshot3.data!) {
                                    if (house.id == chats.elementAt(index)?.houseId1) {
                                      houseName1 = house.name;
                                      break;
                                    }
                                  }

                                  // Get name of house 2
                                  String houseName2 = "";
                                  for (var house in snapshot3.data!) {
                                    if (house.id == chats.elementAt(index)?.houseId2) {
                                      houseName2 = house.name;
                                      break;
                                    }
                                  }

                                  return Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0x54F7F7F7), // Change the color to your preference
                                          width: 0.5, // Change the width as needed
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        // Navigate to the ChatConversationScreen with user data
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatConversationScreen(
                                              chatId: '$houseName1-$houseName2',
                                              userProfileImage: 'assets/images/profile_img.png', // Replace with actual user data
                                            ),
                                          ),
                                        );
                                      },
                                      title: Text("$houseName1 - $houseName2", style: const TextStyle(color: Color(0xFFF7F7F7), fontWeight: FontWeight.w800)),
                                      subtitle: const Text(
                                        'Last message goes here...',
                                        style: TextStyle(color: Color(0xA1F7F7F7)),
                                      ),
                                      leading: const CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/profile_img.png'), // Replace with actual user data
                                      ),
                                    ),

                                  );

                                }
                              }
                            );
                          },
                        );
                      }
                    },
                  );
                }
              }
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CreateFeedScreen when FloatingActionButton is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HouseMapScreen(title: 'test',),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor:Color(0xFFA1C47E),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
