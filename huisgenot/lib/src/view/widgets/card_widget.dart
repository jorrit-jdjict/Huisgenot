import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      color:
          Colors.transparent, // Set the card's background color to transparent
      elevation: 0, // Add elevation for a soft shadow
      shadowColor:
          Colors.black.withOpacity(0.2), // Set shadow color with opacity
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5, // Set the blur radius
                      spreadRadius: 2, // Set the spread radius
                    ),
                  ],
                ),
                child: ClipRRect(
                  // Add ClipRRect to give rounded corners
                  borderRadius:
                      BorderRadius.circular(10), // Set the border radius
                  child: Image.asset(
                    'assets/images/card_image.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Evenement'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Flunkyballen in Stadspark met huize Tijgers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '2 nov - 20:00',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 0,
            child: RawMaterialButton(
              onPressed: () {
                // Handle button tap
              },
              shape: CircleBorder(),
              elevation: 0,
              fillColor: colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
