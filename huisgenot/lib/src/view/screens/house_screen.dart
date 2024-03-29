import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/house_controller.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/house_model.dart';
import 'package:huisgenot/src/model/user_model.dart';
import 'package:huisgenot/src/view/screens/create_feed_or_event_screen.dart';
import 'package:huisgenot/src/view/screens/feed_screen.dart';
import 'package:huisgenot/src/view/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/profile_widget.dart';

class HouseScreen extends StatelessWidget {
  final UserController _userController = UserController();
  final HouseController _houseController = HouseController();

  HouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Haal de document-ID op uit SharedPreferences
    Future<String?> getDocumentId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userDocumentId');
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              stops: [0, 1],
            ),
          ),
        ),
        title: const Text('Profiel', style: TextStyle(color: Colors.white)),
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.all(8.0),
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.edit,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         // Handle the edit button click
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<String?>(
          // Haal de document-ID op uit SharedPreferences
          future: getDocumentId(),
          builder: (BuildContext context,
              AsyncSnapshot<String?> documentIdSnapshot) {
            if (documentIdSnapshot.connectionState == ConnectionState.done) {
              if (documentIdSnapshot.hasData) {
                String documentId = documentIdSnapshot.data!;
                return FutureBuilder<User?>(
                  future: _userController.getUserById(documentId),
                  builder: (BuildContext context,
                      AsyncSnapshot<User?> userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.done) {
                      if (userSnapshot.hasData) {
                        User user = userSnapshot.data!;
                        final String houseId = user.house_id;

                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  'assets/images/profile_img.png',
                                ),
                              ),
                              const SizedBox(height: 10),
                              FutureBuilder<House?>(
                                future: _houseController.getHouseById(houseId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<House?> houseSnapshot) {
                                  if (houseSnapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (houseSnapshot.hasData) {
                                      House house = houseSnapshot.data!;
                                      return buildHouseInfo(house);
                                    } else if (houseSnapshot.hasError) {
                                      return Center(
                                        child: Text(
                                            'Error: ${houseSnapshot.error}'),
                                      );
                                    }
                                  }

                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                'Huisgenoten',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              FutureBuilder<List<User>>(
                                future:
                                    _userController.getUsersInHouse(houseId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<User>>
                                        housematesSnapshot) {
                                  if (housematesSnapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (housematesSnapshot.hasData) {
                                      List<User> housemates =
                                          housematesSnapshot.data!;
                                      return buildHousemates(housemates);
                                    } else if (housematesSnapshot.hasError) {
                                      return Center(
                                        child: Text(
                                            'Error: ${housematesSnapshot.error}'),
                                      );
                                    }
                                  }

                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (userSnapshot.hasError) {
                        return Center(
                          child: Text('Error: ${userSnapshot.error}'),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else {
                // Geen document-ID gevonden in SharedPreferences
                return Center(
                  child: Text('Geen document-ID gevonden in SharedPreferences'),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        onHomePressed: () {
          // Home knop gaat naar FeedScreen
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FeedScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        },
        onAddPressed: () {
          // Image knop gaat naar HouseScreen
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CreateFeedOrEventScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        },
        onProfilePressed: () {},
      ),
    );
  }
}

Widget buildHouseInfo(House house) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        house.name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Text(
        house.address,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 161, 196, 126),
        ),
      ),
      Text(
        house.description,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ],
  );
}
