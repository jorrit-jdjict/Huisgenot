import 'package:flutter/material.dart';
import 'package:huisgenot/src/view/screens/startpagina_screen.dart';

/// The Widget that configures your application.
class HuisGenot extends StatelessWidget {
  const HuisGenot({super.key});

  final ColorScheme myColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    error: Color(0xFFF32424),
    background: Color(0xFF0D1702),
    onBackground: Color(0xFF0D1702),
    surface: Color(0xFF426421),
    onSurface: Color.fromARGB(255, 52, 78, 26),
    onError: Color(0xFFF32424),
    primary: Color.fromARGB(255, 161, 196, 126), // Define your primary color
    secondary: Color.fromARGB(255, 46, 72, 20), // Define your secondary color
    onPrimary: Color(0xFFF7F7F7),
    onSecondary: Color(0xFF0D1702),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huisgenot',
      theme: ThemeData(colorScheme: myColorScheme),
      // home: FeedScreen(),
      // home: LoginScreen(),
      home: StartpaginaScreen(),
    );
  }
}
