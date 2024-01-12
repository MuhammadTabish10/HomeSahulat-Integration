class Message {
  final String sender;
  final String content;

  Message({
    required this.sender,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: json['sender'] as String,
        content: json['content'] as String,
      );

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'content': content,
      };
}