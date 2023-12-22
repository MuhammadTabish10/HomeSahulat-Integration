// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/models/user.dart';
import 'package:homesahulat_fyp/utilities/full_screen_image.dart';
import 'package:homesahulat_fyp/widget/build_profile_item.dart';
import 'dart:convert';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:homesahulat_fyp/models/location.dart';
import 'package:provider/provider.dart';

import '../config/token_provider.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late User user = User(name: '', password: '', phone: '', email: '');
  late String token;
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    token = Provider.of<TokenProvider>(context, listen: false).token;
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
      body: Container(
        decoration: const BoxDecoration(
          // Add a background image to the container
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
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
            buildProfileItem('Email', user.email),
            buildProfileItem('First Name', user.firstName ?? ''),
            buildProfileItem('Last Name', user.lastName ?? ''),
            buildProfileItem('Phone', user.phone),
            buildLocationInfo(user.location ??
                Location(
                  id: 0,
                  name: '',
                  address: '',
                  city: '',
                  state: '',
                  postalCode: 0,
                  country: '',
                  latitude: 0.0,
                  longitude: 0.0,
                  status: false,
                )),
          ],
        ),
      ),
    );
  }
}
