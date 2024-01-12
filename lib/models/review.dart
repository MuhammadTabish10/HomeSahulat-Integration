import 'dart:convert';

import 'package:homesahulat_fyp/models/service_provider.dart';
import 'package:homesahulat_fyp/models/user.dart';

Review reviewJson(String str) => Review.fromJson(json.decode(str));
String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  final int id;
  final DateTime createdAt;
  final String note;
  final double rating;
  final bool status;
  // final ServiceProvider serviceProvider;
  final User user;

  Review({
    required this.id,
    required this.createdAt,
    required this.note,
    required this.rating,
    required this.status,
    // required this.serviceProvider,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['id'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
        note: json['note'] as String,
        rating: json['rating'] as double,
        status: json['status'] as bool,
        // serviceProvider: ServiceProvider.fromJson(json['serviceProvider']),
        user: User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'note': note,
        'rating': rating,
        'status': status,
        // 'serviceProvider': serviceProvider.toJson(),
        'user': user.toJson(),
      };
}
