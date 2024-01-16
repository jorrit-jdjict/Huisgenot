import 'package:flutter/material.dart';
import 'package:huisgenot/src/controller/user_controller.dart';
import 'package:huisgenot/src/model/user_model.dart';
import 'package:huisgenot/src/view/screens/feed_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final UserController _userController = UserController();

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
            ElevatedButton(
              onPressed: () async {
                String first_name = _firstNameController.text;
                String last_name = _lastNameController.text;

                if (first_name.isNotEmpty && last_name.isNotEmpty) {
                  User user = User(
                    id: '',
                    first_name: first_name,
                    last_name: last_name,
                    bio: '',
                    house_id: '',
                  );

                  await _userController.addUserToFirebase(user);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FeedScreen()),
                  );
                } else {
                  // Toon een foutmelding dat de velden niet leeg mogen zijn
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Voer zowel voornaam als achternaam in.',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: const Text('Profiel aanmaken',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
