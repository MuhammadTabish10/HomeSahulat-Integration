// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/models/user.dart';
import 'package:homesahulat_fyp/utilities/full_screen_image.dart';
import 'package:homesahulat_fyp/widget/build_profile_item.dart';
import 'dart:convert';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:http/http.dart' as http;

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late User user = User(name: '', password: '', phone: '');
  late String token;
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    isMounted = true;
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    // Extract arguments here
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      token = args['token'] ?? '';
    } else {
      // Handle the case where arguments are null
      token = '';
    }

    try {
      final loggedInUser = await getUser(token);
      if (isMounted) {
        setState(() {
          user = loggedInUser;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<User> getUser(String token) async {
    String apiUrl = getLoggedInUserUrl;
    final Uri uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        User user = User.fromJson(userData);
        return user;
      } else {
        print('Failed to load logged in user: ${response.statusCode}');
        return user;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImage(user.profilePictureUrl ?? ''),
                ),
              );
            },
            child: Hero(
              tag: 'profile_image',
              child: Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(user.profilePictureUrl ?? ''),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          buildProfileItem('Name', user.name),
          buildProfileItem('Email', user.email ?? ''),
          buildProfileItem('First Name', user.firstName ?? ''),
          buildProfileItem('Last Name', user.lastName ?? ''),
          buildProfileItem('Phone', user.phone),
          // Add more profile items as needed
        ],
      ),
    );
  }
}
