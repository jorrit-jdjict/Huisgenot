import 'dart:developer';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:huisgenot/src/controller/chat_controller.dart';

import '../../controller/house_controller.dart';
import '../../controller/user_controller.dart';
import '../../model/chat_model.dart';
import '../../model/house_model.dart';
import '../../model/user_model.dart';
import '../widgets/profile_widget.dart';
import 'chat_conversation_screen.dart';


class HouseMapScreen extends StatefulWidget {
  const HouseMapScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HouseMapScreen> createState() => _HouseMapScreenState();
}

class _HouseMapScreenState extends State<HouseMapScreen> {
  late GoogleMapController mapController;
  final UserController _userController = UserController();
  final ChatController _chatController = ChatController();
  final HouseController _houseController = HouseController();

  late BitmapDescriptor houseIcon;
  final LatLng _center = const LatLng(53.23, 6.570570);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  List<House> houses = []; // Initialize with an empty list
  Set<Marker> _getMarkers() {
    return houses
        .map(
          (house) => Marker(
        markerId: MarkerId(house.id),
        position: LatLng(house.lat, house.lng),
            icon: houseIcon,
            onTap: () {
              _showCustomInfoWindow(house);
            },
      ),
    ).toSet();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Buurt map ', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF0D1702),
          leading: Container(
            margin: const EdgeInsets.all(8.0), // Add margin here
            child: IconButton(
              icon: const Icon(Icons.chevron_left , color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),),

        body: StreamBuilder<List<House>>(
          stream: _houseController.getHouses(), // Assuming getHouses is accessible here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              houses = snapshot.data ?? []; // Update the houses list
              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                markers: _getMarkers(),
              );
            }
          },
        ),
      ),
    );

  }
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(4, 4)), 'assets/images/house_icon.png')
        .then((onValue) {
      houseIcon = onValue;
    });
  }
  void _showCustomInfoWindow(House house) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false, // Set to true to allow scrolling
      builder: (context) {
      return StreamBuilder<List<User>>(
          stream: _userController.getUsers(),
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {

              // TODO: Replace with dynamic user id
              var userId = "7sZXYmgI4KM5UoItkr1l";

              // Get house ID of user
              String userHouseId = "";
              for (var user in snapshot1.data!) {
                print(user.id);
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
                                    (chat.houseId1 == house.id && chat.houseId2 == userHouseId) ||
                                    (chat.houseId1 == userHouseId && chat.houseId2 == house.id)
                                  ) {
                                    var houseName1 = "";
                                    var houseName2 = "";

                                    // Get house names
                                    for (var houseEntity in snapshot3.data!) {
                                      if (houseEntity.id == chat.houseId1) {
                                        houseName1 = houseEntity.name;
                                      } else if (houseEntity.id == chat.houseId2) {
                                        houseName2 = houseEntity.name;
                                      }
                                    }

                                    chatId = '$houseName1-$houseName2';
                                  }
                                }

                                return SingleChildScrollView( // Wrap content with SingleChildScrollView
                                  child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      color: Color(0xFF0D1702),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(house.name,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w800)),
                                                  Text(house.address, style: TextStyle(
                                                      color: Color(0xFFA1C47E))),
                                                ],
                                              ),

                                              // Button
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.send,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      // Handle button press
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatConversationScreen(
                                                                chatId:
                                                                chatId,
                                                                userProfileImage:
                                                                'assets/images/profile_img.png', // Replace with actual user data
                                                              ),
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 8.0),
                                          // Add spacing as needed
                                          Text(
                                            'Bewoners',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          _buildHousematesFutureBuilder(house.id),
                                        ],
                                      )
                                  ),
                                );
                              } else if (snapshot3.hasError) {
                                inspect(snapshot3.error); // Inspect the error
                                return Text('Error: ${snapshot3.error}');
                              }
                              return const Center(child: CircularProgressIndicator());
                            }
                        );
                      } else if (snapshot2.hasError) {
                        inspect(snapshot2.error); // Inspect the error
                        return Text('Error: ${snapshot2.error}');
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                );
            } else if (snapshot1.hasError) {
              inspect(snapshot1.error); // Inspect the error
              return Text('Error: ${snapshot1.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }
        );
      },
    );
  }

  Widget _buildHousematesFutureBuilder(String houseId) {
    return FutureBuilder<List<User>>(
      future: _userController.getUsersInHouse(houseId),
      builder: (BuildContext context, AsyncSnapshot<List<User>> housematesSnapshot) {
        if (housematesSnapshot.connectionState == ConnectionState.done) {
          if (housematesSnapshot.hasData) {
            List<User> housemates = housematesSnapshot.data!;
            return buildHousemates(housemates);
          } else if (housematesSnapshot.hasError) {
            return Center(
              child: Text('Error: ${housematesSnapshot.error}'),
            );
          }
        }
        return Text('');
      },
    );
  }


}
