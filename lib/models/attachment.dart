import 'dart:convert';

Attachment attachmentJson(String str) => Attachment.fromJson(json.decode(str));
String attachmentToJson(Attachment data) => json.encode(data.toJson());

class Attachment {
  String cnicUrl;

  Attachment({
    required this.cnicUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      cnicUrl: json['cnicUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cnicUrl': cnicUrl,
    };
  }
}
