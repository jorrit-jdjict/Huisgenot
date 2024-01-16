import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/user_model.dart';
import 'package:huisgenot/src/view/screens/feed_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final UserController _userController = UserController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                decoration: const InputDecoration(
                  labelText: 'Voornaam',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
                decoration: const InputDecoration(
                  labelText: 'Achternaam',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;

                if (firstName.isNotEmpty && lastName.isNotEmpty) {
                  User user = User(
                    id: '',
                    firstName: firstName,
                    lastName: lastName,
                    bio: '',
                    houseId: '',
                  );

                  await _userController.addUserToFirebase(user);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FeedScreen()),
                  );
                } else {
                  // Toon een foutmelding dat de velden niet leeg mogen zijn
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Voer zowel voornaam als achternaam in.'),
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: const Text('Inloggen'),
            ),
          ],
        ),
      ),
    );
  }
}
