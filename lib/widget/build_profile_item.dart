import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/models/location.dart';


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

Widget buildLocationInfo(Location location) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildProfileItem('Address', location.address),
      buildProfileItem('City', location.city),
      buildProfileItem('State', location.state),
      buildProfileItem('Postal Code', location.postalCode.toString()),
      buildProfileItem('Country', location.country),
    ],
  );
}