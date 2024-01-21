// import 'package:homesahulat_fyp/models/user.dart';
// import 'package:homesahulat_fyp/models/services.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

// ServiceProvider serviceProviderJson(String str) =>
//     ServiceProvider.fromJson(json.decode(str));
// String serviceProviderToJson(ServiceProvider data) =>
//     json.encode(data.toJson());

// class ServiceProvider {
//   int id;
//   DateTime? createdAt;
//   String description;
//   String cnicNo;
//   double hourlyPrice;
//   double totalExperience;
//   double? totalRating;
//   bool? atWork;
//   // String? cnicUrl;
//   bool haveShop;
//   bool? status;
//   User user;
//   Services services;

//   ServiceProvider({
//     required this.id,
//     this.createdAt,
//     required this.description,
//     required this.cnicNo,
//     required this.hourlyPrice,
//     required this.totalExperience,
//     this.totalRating,
//     this.atWork,
//     required this.haveShop,
//     this.status,
//     // this.cnicUrl,
//     required this.user,
//     required this.services,
//   });

//   factory ServiceProvider.fromJson(Map<String, dynamic> json) {
//     return ServiceProvider(
//       id: json['id'],
//       createdAt: DateTime.parse(json['createdAt']),
//       description: json['description'] as String,
//       cnicNo: json['cnicNo'] as String,
//       hourlyPrice: json['hourlyPrice'].toDouble(),
//       totalExperience: json['totalExperience'].toDouble(),
//       totalRating: json['totalRating'].toDouble(),
//       atWork: json['atWork'] as bool,
//       haveShop: json['haveShop'] as bool,
//       // cnicUrl: json['cnicUrl'] as String,
//       status: json['status'] as bool,
//       user: User.fromJson(json['user']),
//       services: Services.fromJson(json['services']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
//     return {
//       'id': id,
//       'createdAt': formatter.format(createdAt!.toUtc()),
//       'description': description,
//       'cnicNo': cnicNo,
//       'hourlyPrice': hourlyPrice,
//       'totalExperience': totalExperience,
//       'totalRating': totalRating,
//       'atWork': atWork,
//       'haveShop': haveShop,
//       // 'cnicUrl': cnicUrl,
//       'status': status,
//       'user': user.toJson(),
//       'services': services.toJson(),
//     };
//   }
// }


import 'package:homesahulat_fyp/models/user.dart';
import 'package:homesahulat_fyp/models/services.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

ServiceProvider serviceProviderJson(String str) =>
    ServiceProvider.fromJson(json.decode(str));
String serviceProviderToJson(ServiceProvider data) =>
    json.encode(data.toJson());

class ServiceProvider {
  int id;
  DateTime? createdAt;
  String description;
  String cnicNo;
  double hourlyPrice;
  double totalExperience;
  double? totalRating;
  bool? atWork;
  bool haveShop;
  bool? status;
  User user;
  Services services;

  ServiceProvider({
    required this.id,
    this.createdAt,
    required this.description,
    required this.cnicNo,
    required this.hourlyPrice,
    required this.totalExperience,
    this.totalRating,
    this.atWork,
    required this.haveShop,
    this.status,
    required this.user,
    required this.services,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'] as int,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      description: json['description'] as String,
      cnicNo: json['cnicNo'] as String,
      hourlyPrice: json['hourlyPrice'].toDouble(),
      totalExperience: json['totalExperience'].toDouble(),
      totalRating: json['totalRating']?.toDouble(),
      atWork: json['atWork'] as bool?,
      haveShop: json['haveShop'] as bool,
      status: json['status'] as bool?,
      user: User.fromJson(json['user']),
      services: Services.fromJson(json['services']),
    );
  }

  Map<String, dynamic> toJson() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'description': description,
      'cnicNo': cnicNo,
      'hourlyPrice': hourlyPrice,
      'totalExperience': totalExperience,
      'totalRating': totalRating,
      'atWork': atWork,
      'haveShop': haveShop,
      'status': status,
      'user': user.toJson(),
      'services': services.toJson(),
    };
  }
}
