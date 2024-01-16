import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/house_controller.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/house_model.dart';
import 'package:huisgenot/src/model/user_model.dart';
import 'package:huisgenot/src/view/screens/feed_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final UserController _userController = UserController();
  final HouseController _houseController = HouseController();
  House? _selectedHouse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'Voornaam',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Achternaam',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: 'Vertel wat over jezelf',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: StreamBuilder<List<House>>(
                stream: _houseController.getHouses(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<House>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      List<House> allHouses = snapshot.data!;
                      return Container(
                        width: double.infinity,
                        child: DropdownButton<House>(
                          isExpanded: true,
                          iconEnabledColor: Color.fromARGB(255, 46, 72, 20),
                          items: allHouses.map((House house) {
                            return DropdownMenuItem<House>(
                              value: house,
                              child: Text(
                                house.name,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 161, 196, 126),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (House? selectedHouse) {
                            setState(() {
                              _selectedHouse = selectedHouse;
                            });
                          },
                          hint: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: const Text(
                              'Selecteer een huis',
                              style: TextStyle(
                                color: Color.fromARGB(255, 46, 72, 20),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String first_name = _firstNameController.text;
                String last_name = _lastNameController.text;
                String bio = _bioController.text;

                if (first_name.isNotEmpty &&
                    last_name.isNotEmpty &&
                    _selectedHouse != null) {
                  User user = User(
                    id: '',
                    first_name: first_name,
                    last_name: last_name,
                    bio: bio,
                    house_id: _selectedHouse!.id,
                  );

                  await _userController.addUserToFirebase(user);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Voer zowel voornaam, achternaam, en selecteer een huis in.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: const Text(
                'Profiel aanmaken',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
