
import 'package:homesahulat_fyp/models/user.dart';
import 'package:homesahulat_fyp/models/services.dart';
import 'package:homesahulat_fyp/models/attachment.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

ServiceProvider serviceProviderJson(String str) =>
    ServiceProvider.fromJson(json.decode(str));
String serviceProviderToJson(ServiceProvider data) =>
    json.encode(data.toJson());

class ServiceProvider {
  int id;
  DateTime createdAt;
  String description;
  double hourlyPrice;
  double totalExperience;
  double totalRating;
  bool atWork;
  bool haveShop;
  bool status;
  User user;
  Services services;
  List<Attachment> attachment;

  ServiceProvider({
    required this.id,
    required this.createdAt,
    required this.description,
    required this.hourlyPrice,
    required this.totalExperience,
    required this.totalRating,
    required this.atWork,
    required this.haveShop,
    required this.status,
    required this.user,
    required this.services,
    required this.attachment,
  });

factory ServiceProvider.fromJson(Map<String, dynamic> json) {
  return ServiceProvider(
    id: json['id'],
    createdAt: DateTime.parse(json['createdAt']),
    description: json['description'] as String,
    hourlyPrice: json['hourlyPrice'].toDouble(),
    totalExperience: json['totalExperience'].toDouble(),
    totalRating: json['totalRating'].toDouble(),
    atWork: json['atWork'] as bool,
    haveShop: json['haveShop'] as bool,
    status: json['status'] as bool,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    services: Services.fromJson(json['services'] as Map<String, dynamic>),
    attachment: (json['attachment'] as List<dynamic>)
      .map((attachment) => Attachment.fromJson(attachment as Map<String, dynamic>))
      .toList(),
  );
}




  Map<String, dynamic> toJson() {
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  return {
    'id': id,
    'createdAt': formatter.format(createdAt.toUtc()),
    'description': description,
    'hourlyPrice': hourlyPrice,
    'totalExperience': totalExperience,
    'totalRating': totalRating,
    'atWork': atWork,
    'haveShop': haveShop,
    'status': status,
    'user': user.toJson(), 
    'services': services.toJson(), 
    'attachment': attachment.map((a) => a.toJson()).toList(), 
  };
}

}
