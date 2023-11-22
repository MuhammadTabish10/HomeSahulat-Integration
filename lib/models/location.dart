import 'dart:convert';

Location locationJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  int id;
  String name;
  String address;
  String city;
  String state;
  int postalCode;
  String country;
  double latitude;
  double longitude;
  bool status;

  Location({
   required this.id,
   required this.name,
   required this.address,
   required this.city,
   required this.state,
   required this.postalCode,
   required this.country,
   required this.latitude,
   required this.longitude,
   required this.status,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'status': status
    };
  }
}
