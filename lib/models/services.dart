import 'dart:convert';

Services servicesJson(String str) => Services.fromJson(json.decode(str));
String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
  int id;
  String name;
  String description;
  bool status;

  Services({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'] is int ? json['id'] as int : int.parse(json['id']),
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
    };
  }
}
