import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';
import 'package:homesahulat_fyp/models/user.dart';

class Booking {
  int id;
  DateTime? createdAt;
  DateTime? appointmentDate;
  TimeOfDay? appointmentTime;
  bool status;
  String? bookingStatus;
  User user;
  ServiceProvider? serviceProvider;

  Booking({
    required this.id,
    required this.createdAt,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    this.bookingStatus,
    required this.user,
    this.serviceProvider,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      createdAt: _parseDateTime(json['createdAt']),
      appointmentDate: _parseDate(json['appointmentDate']),
      appointmentTime: _parseTime(json['appointmentTime']),
      status: json['status'] as bool,
      bookingStatus: json['bookingStatus'] as String,
      user: User.fromJson(_excludeNullFields(json['user'])),
      serviceProvider: ServiceProvider.fromJson(
        json['serviceProvider'],
      ),
    );
  }

  static DateTime? _parseDateTime(String? dateTimeString) {
    if (dateTimeString == null) return null;
    return DateTime.parse(dateTimeString);
  }

  static DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    return DateTime.parse(dateString);
  }

  static TimeOfDay? _parseTime(String? timeString) {
    if (timeString == null) return null;
    final components = timeString.split(':');
    return TimeOfDay(
        hour: int.parse(components[0]), minute: int.parse(components[1]));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'appointmentDate': _formatDate(appointmentDate!),
        'appointmentTime': _formatTime(appointmentTime!),
        'status': status,
        'bookingStatus': bookingStatus,
        'user': user.toJson(),
        'serviceProvider': serviceProvider!.toJson(),
      };

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  static Map<String, dynamic> _excludeNullFields(Map<String, dynamic>? json) {
    // If json is null, return an empty map
    if (json == null) {
      return {};
    }

    // Remove null fields from the map
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
