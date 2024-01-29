// bottom_navigation.dart

import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final Function() onHomePressed;
  final Function() onAddPressed;
  final Function() onProfilePressed;

  const CustomBottomNavigation({
    required this.onHomePressed,
    required this.onAddPressed,
    required this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onHomePressed,
              icon: Icon(Icons.home, color: Colors.white),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 161, 196, 126),
              ),
              child: IconButton(
                onPressed: onAddPressed,
                icon: Icon(Icons.add, color: Colors.white),
              ),
            ),
            IconButton(
              onPressed: onProfilePressed,
              icon: Container(
                width: 34.0,
                height: 34.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_img.png'),
                    fit: BoxFit.cover,
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
