import 'dart:math';
import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Randomly select an image ID
    int imageId = Random().nextInt(4) +
        1; // Adjust the number based on the number of images you have
    String imagePath = 'assets/images/ad$imageId.jpeg';

    return Container(
      padding: EdgeInsets.fromLTRB(12, 40, 12, 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8), // Space between image and text
          Text(
            "Pizzeria DiStefano!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          // You can add more text or styling as needed
        ],
      ),
    );
  }
}
