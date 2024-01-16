import 'package:flutter/material.dart';
import 'package:huisgenot/src/view/screens/login_screen.dart';

class StartpaginaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colorScheme.background,
        body: Stack(
          children: [
            Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('assets/images/huisgenot_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  height: 175,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 20, // Adjust the left padding
              right: 20, // Adjust the right padding
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: colorScheme.background,
                    minimumSize: Size(200, 50), // Set the button height
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0,
        size.height - 20); // Move to the bottom-left corner with some padding
    path.lineTo(0, 20); // Move to the top-left corner with some padding
    path.quadraticBezierTo(0, 0, 20, 0); // Create a curve at the top-left
    path.lineTo(
        size.width - 20, 0); // Move to the top-right corner with some padding
    path.quadraticBezierTo(
        size.width, 0, size.width, 20); // Create a curve at the top-right
    path.lineTo(size.width,
        size.height - 20); // Move to the bottom-right corner with some padding
    path.quadraticBezierTo(size.width, size.height, size.width - 20,
        size.height); // Create a curve at the bottom-right
    path.lineTo(
        20, size.height); // Move to the bottom-left corner with some padding
    path.quadraticBezierTo(0, size.height, 0,
        size.height - 20); // Create a curve at the bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
