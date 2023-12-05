import 'package:homesahulat_fyp/models/service_provider.dart';
import 'package:homesahulat_fyp/models/user.dart';

class Booking {
  int id;
  DateTime createdAt;
  DateTime appointmentDate;
  DateTime appointmentTime;
  bool status;
  User user;
  ServiceProvider serviceProvider;

  Booking({
    required this.id,
    required this.createdAt,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.user,
    required this.serviceProvider,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as int,
        createdAt: DateTime.parse(json['createdAt']),
        appointmentDate: DateTime.parse(json['appointmentDate']),
        appointmentTime: DateTime.parse(json['appointmentTime']),
        status: json['status'] as bool,
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        serviceProvider:
            ServiceProvider.fromJson(json['serviceProvider'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'appointmentDate': appointmentDate.toIso8601String(),
        'appointmentTime': appointmentTime.toIso8601String(),
        'status': status,
        'user': user.toJson(),
        'serviceProvider': serviceProvider.toJson(),
      };
}
