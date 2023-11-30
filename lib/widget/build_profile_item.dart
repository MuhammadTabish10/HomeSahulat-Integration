import 'package:flutter/material.dart';

Widget buildProfileItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8.0),
      Text(
        value,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      const Divider(),
    ],
  );
}
