import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

Widget buildHousemates(List<User> housemates) {
  return Column(
    children: [
      for (User housemate in housemates)
        _buildHousemate(
            '${housemate.first_name} ${housemate.last_name}', housemate.bio),
    ],
  );
}

Widget _buildHousemate(String name, String bio) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: Color.fromARGB(255, 161, 196, 126),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              bio,
              style: TextStyle(color: Color.fromARGB(255, 161, 196, 126)),
            ),
          ],
        ),
      ],
    ),
  );
}