import 'dart:convert';

import 'package:homesahulat_fyp/models/location.dart';

User userJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  final String name;
  final String password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String phone;
  final String? profilePictureUrl;
  final String? deviceId;
  final String? otp;
  final bool? otpFlag;
  final Location? location;

  User({
    required this.name,
    required this.password,
    this.email,
    this.firstName,
    this.lastName,
    required this.phone,
    this.profilePictureUrl,
    this.deviceId,
    this.otp,
    this.otpFlag,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      password: json['password'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      profilePictureUrl: json['profilePictureUrl'],
      deviceId: json['deviceId'],
      otp: json['otp'],
      otpFlag: json['otpFlag'],
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'profilePictureUrl': profilePictureUrl,
      'deviceId': deviceId,
      'otp': otp,
      'otpFlag': otpFlag,
      'location': location?.toJson(),
    };
  }
}
