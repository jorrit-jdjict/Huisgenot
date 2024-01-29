import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/house_controller.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/chat_model.dart';
import 'package:huisgenot/src/model/feed_model.dart';

import '../../controller/chat_controller.dart';
import '../../model/house_model.dart';
import '../../model/user_model.dart';
import '../screens/chat_conversation_screen.dart';

class CardWidget extends StatelessWidget {
  final FeedItem feedItem;

  const CardWidget({Key? key, required this.feedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    // TODO: Replace with dynamic user id
    var userId = "7sZXYmgI4KM5UoItkr1l";

    final _userController = UserController();
    final _chatController = ChatController();
    final _houseController = HouseController();

    return StreamBuilder<List<User>>(
        stream: _userController.getUsers(),
        builder: (context, snapshot1) {
          if (snapshot1.hasData) {

            // Get house ID of user
            String userHouseId = "";
            for (var user in snapshot1.data!) {
              if (user.id == userId) {
                userHouseId = user.house_id;
                break;
              }
            }

            return StreamBuilder<List<Chat>>(
                stream: _chatController.getChats(),
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {

                    return StreamBuilder<List<House>>(
                        stream: _houseController.getHouses(),
                        builder: (context, snapshot3) {
                          if (snapshot3.hasData) {

                            // Get chat ID of chat between this house and event hoster's house
                            String chatId = "";
                            for (var chat in snapshot2.data!) {
                              if (
                                (chat.houseId1 == feedItem.postAuthor.id && chat.houseId2 == userHouseId) ||
                                (chat.houseId1 == userHouseId && chat.houseId2 == feedItem.postAuthor.id)
                              ) {
                                var houseName1 = "";
                                var houseName2 = "";

                                // Get house names
                                for (var house in snapshot3.data!) {
                                  if (house.id == chat.houseId1) {
                                    houseName1 = house.name;
                                  } else if (house.id == chat.houseId2) {
                                    houseName2 = house.name;
                                  }
                                }

                                chatId = '$houseName1-$houseName2';
                              }
                            }

                            return Card(
                              margin: const EdgeInsets.fromLTRB(10, 0, 12, 12),
                              color: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.black.withOpacity(0.2),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                    mainAxisAlignment: MainAxisAlignment.end, // Align text to the bottom
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            feedItem.imageUrl,
                                            height: 200,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Auteur: ${feedItem.postAuthor.name}'.toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: colorScheme.primary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              feedItem.postTitle,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '${feedItem.postDate.day}/${feedItem.postDate.month}/${feedItem.postDate.year} @ ${feedItem.postDate.hour}:${feedItem.postDate.minute}',
                                              style: TextStyle(fontSize: 14, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    right: 0,
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        // Handle button tap
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatConversationScreen(
                                              chatId: chatId,
                                              userProfileImage:
                                              'assets/images/profile_img.png', // Replace with actual user data
                                            ),
                                          ),
                                        );
                                      },
                                      shape: CircleBorder(),
                                      elevation: 0,
                                      fillColor: colorScheme.primary,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                          } else if (snapshot3.hasError) {
                            inspect(snapshot3.error); // Inspect the error
                            return Text('Error: ${snapshot3.error}');
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }
                    );
                  } else if (snapshot2.hasError) {
                    inspect(snapshot2.error); // Inspect the error
                    return Text('Error: ${snapshot2.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            );
          } else if (snapshot1.hasError) {
            inspect(snapshot1.error); // Inspect the error
            return Text('Error: ${snapshot1.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
