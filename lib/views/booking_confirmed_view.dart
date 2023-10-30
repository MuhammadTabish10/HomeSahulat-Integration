import 'package:flutter/material.dart';
import '../constants/routes.dart';

class BookingConfirmedView extends StatefulWidget {
  const BookingConfirmedView({Key? key}) : super(key: key);

  @override
  State<BookingConfirmedView> createState() => _BookingConfirmedViewState();
}

class _BookingConfirmedViewState extends State<BookingConfirmedView> {
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
        title: const Text('Booking Confirmation'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Jamil Anwar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'You have successfully booked Jamil Anwar to fix your problem.\nGet in touch with Jamil for further details.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle message button click
                        Navigator.pushNamed(context, chatRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3ECAB0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        'Message',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle view profile button click
                        Navigator.pushNamed(
                            context, serviceProviderProfileRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF061C43),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        'View Profile',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.all(8),
              child: const Text(
                'How may I help you?',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
