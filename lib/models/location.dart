import 'dart:convert';

Location locationJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  final int? id;
  String address;
  String city;
  final String state;
  final int postalCode;
  final String country;
  final double? latitude;
  final double? longitude;
  final bool? status;

  Location({
    this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.latitude,
    this.longitude,
    this.status,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }
}