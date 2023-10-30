import 'dart:convert';

User userJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  // final String name;
  final String password;
  // final String email;
  // final String firstName;
  // final String lastName;
  final String phone;
  // final String profilePictureUrl;
  // final String deviceId;

  User({
    // required this.name,
    required this.password,
    // required this.email,
    // required this.firstName,
    // required this.lastName,
    required this.phone,
    // required this.profilePictureUrl,
    // required this.deviceId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // name: json['name'],
      password: json['password'],
      // email: json['email'],
      // firstName: json['firstName'],
      // lastName: json['lastName'],
      phone: json['phone'],
      // profilePictureUrl: json['profilePictureUrl'],
      // deviceId: json['deviceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'name': name,
      'password': password,
      // 'email': email,
      // 'firstName': firstName,
      // 'lastName': lastName,
      'phone': phone,
      // 'profilePictureUrl': profilePictureUrl,
      // 'deviceId': deviceId,
    };
  }
}
