import 'dart:convert';
import 'package:homesahulat_fyp/models/role.dart';
import 'package:intl/intl.dart';
import 'package:homesahulat_fyp/models/location.dart';

User userJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? id;
  final DateTime? createdAt;
  final String name;
  final String password;
  final String email;
  final String phone;
  final String? profilePictureUrl;
  final String? deviceId;
  final String? otp;
  final bool? otpFlag;
  final bool? status;
  final List<Role>? roles; 
  Location? location;

  User({
    this.id,
    this.createdAt,
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    this.profilePictureUrl,
    this.deviceId,
    this.otp,
    this.otpFlag,
    this.status,
    this.roles,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      name: json['name'],
      password: json['password'],
      email: json['email'],
      phone: json['phone'],
      profilePictureUrl: json['profilePictureUrl'],
      deviceId: json['deviceId'],
      otp: json['otp'],
      otpFlag: json['otpFlag'],
      status: json['status'],
       roles: json['roles'] != null
          ? List<Role>.from(json['roles'].map((roleJson) => Role.fromJson(roleJson)))
          : null,
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      'id': id,
      'createdAt': formatter.format(createdAt!.toUtc()),
      'name': name,
      'password': password,
      'email': email,
      'phone': phone,
      'profilePictureUrl': profilePictureUrl,
      'deviceId': deviceId,
      'otp': otp,
      'otpFlag': otpFlag,
      'status': status,
      'roles': roles?.map((role) => role.toJson()).toList(),
      'location': location?.toJson(),
    };
  }
}
