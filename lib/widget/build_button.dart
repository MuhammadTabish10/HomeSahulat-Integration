import 'package:flutter/material.dart';

Widget buildButton(IconData icon, String label, VoidCallback onPressed) {
  return SizedBox(
    width: 100,
    height: 80,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: const Color(0xFFB2DFDB),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    ),
  );
}
