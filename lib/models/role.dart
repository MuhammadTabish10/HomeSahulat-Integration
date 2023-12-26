import 'dart:convert';

Role roleJson(String str) => Role.fromJson(json.decode(str));
String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  final int id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
