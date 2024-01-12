// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:homesahulat_fyp/models/message.dart';

// class ChatView extends StatefulWidget {
//   const ChatView({Key? key}) : super(key: key);

//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   List<Message> messages = []; // List to store messages
//   final TextEditingController _textEditingController = TextEditingController();

//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text('Chat'), // Customize the app bar title
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           // Add a background image to the container
//           image: DecorationImage(
//             image: AssetImage('lib/assets/images/design.png'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 reverse: true, // Reverse the list view for chat-like UI
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   final message = messages.reversed.toList()[index];
//                   return Container(
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 4.0, horizontal: 8.0),
//                     child: Align(
//                       alignment: message.sender == 'Customer'
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: message.sender == 'Customer'
//                               ? Colors.blueAccent
//                               : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                         child: Text(
//                           message.content,
//                           style: TextStyle(
//                             color: message.sender == 'Customer'
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 16.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _textEditingController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message',
//                       ),
//                       // Handle sending message logic
//                       onSubmitted: (text) {
//                         _sendMessage(text);
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: () {
//                       _sendMessage(_textEditingController.text);
//                     },
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _sendMessage(String text) {
//     if (text.isNotEmpty) {
//       setState(() {
//         messages.add(Message(
//           sender: 'Customer',
//           content: text,
//         ));
//       });
//       _textEditingController.clear();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// // import 'package:homesahulat_fyp/models/message.dart';

// class ChatScreen extends StatefulWidget {
//   final String roomId;

//   const ChatScreen({super.key, required this.roomId});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final WebSocketChannel _channel =
//       IOWebSocketChannel.connect('ws://localhost:8080/ws');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Room ${widget.roomId}'),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder(
//             stream: _channel.stream,
//             builder: (context, snapshot) {
//               // Handle incoming messages
//               if (snapshot.hasData) {
//                 // Display messages
//                 return Text(snapshot.data.toString());
//               } else {
//                 return const Text('No messages yet.');
//               }
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Type your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     // Send message to the server
//                     _channel.sink.add('{"text": "${_controller.text}"}');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _channel.sink.close();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:homesahulat_fyp/models/message.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Message> messages = [];
  final TextEditingController _textEditingController = TextEditingController();
  final WebSocketChannel _channel =
      IOWebSocketChannel.connect('ws://localhost:8080/ws');

  @override
  void dispose() {
    _textEditingController.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Chat'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages.reversed.toList()[index];
                  return _buildMessage(message);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                      ),
                      onSubmitted: (text) {
                        _sendMessage(text);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      _sendMessage(_textEditingController.text);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: message.sender == 'Customer'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: message.sender == 'Customer'
                ? Colors.blueAccent
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            message.content,
            style: TextStyle(
              color: message.sender == 'Customer' ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      final newMessage = Message(sender: 'Customer', content: text);
      _channel.sink.add(newMessage.toJson());
      setState(() {
        messages.add(newMessage);
      });
      _textEditingController.clear();
    }
  }
}
