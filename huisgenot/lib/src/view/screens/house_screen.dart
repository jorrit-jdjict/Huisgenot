import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/house_controller.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/house_model.dart';
import 'package:huisgenot/src/model/user_model.dart';

import '../widgets/profile_widget.dart';

class HouseScreen extends StatelessWidget {
  final UserController _userController = UserController();
  final HouseController _houseController = HouseController();

  HouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String userId = '7sZXYmgI4KM5UoItkr1l';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiel', style: TextStyle(color: Colors.white)),
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 24.0,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle the edit button click
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<User?>(
        future: _userController.getUserById(userId),
        builder: (BuildContext context, AsyncSnapshot<User?> userSnapshot) {
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
                              child: Text('Error: ${houseSnapshot.error}'),
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
                      future: _userController.getUsersInHouse(houseId),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<User>> housematesSnapshot) {
                        if (housematesSnapshot.connectionState ==
                            ConnectionState.done) {
                          if (housematesSnapshot.hasData) {
                            List<User> housemates = housematesSnapshot.data!;

                            return buildHousemates(housemates);
                          } else if (housematesSnapshot.hasError) {
                            return Center(
                              child: Text('Error: ${housematesSnapshot.error}'),
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
      ),
    );
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


}
