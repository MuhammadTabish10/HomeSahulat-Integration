import 'package:homesahulat_fyp/models/service_provider.dart';
import 'dart:convert';

Attachment attachmentJson(String str) => Attachment.fromJson(json.decode(str));
String attachmentToJson(Attachment data) => json.encode(data.toJson());

class Attachment {
  int id;
  DateTime createdAt;
  String name;
  String fileUrl;
  bool status;
  // ServiceProvider serviceProvider;

  Attachment({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.fileUrl,
    required this.status,
    // required this.serviceProvider,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      fileUrl: json['fileUrl'],
      status: json['status'],
      // serviceProvider: ServiceProvider.fromJson(json['serviceProvider']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'fileUrl': fileUrl,
      'status': status,
      // 'serviceProvider': serviceProvider.toJson(),
    };
  }
}
