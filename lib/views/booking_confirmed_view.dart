import 'package:flutter/material.dart';
import '../constants/routes.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';

class BookingConfirmedView extends StatefulWidget {
  const BookingConfirmedView({Key? key}) : super(key: key);

  @override
  State<BookingConfirmedView> createState() => _BookingConfirmedViewState();
}

class _BookingConfirmedViewState extends State<BookingConfirmedView> {
  late ServiceProvider serviceProvider;
  late String token;
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    isMounted = true;
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    // Extract arguments here
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      token = args['token'] ?? '';
      serviceProvider = args['serviceProvider'] ?? '';
    } else {
      // Handle the case where arguments are null
      token = '';
      serviceProvider = {} as ServiceProvider;
    }
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
                Text(
                  serviceProvider.user.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'You have successfully booked ${serviceProvider.user.name} to fix your problem.\nGet in touch with ${serviceProvider.user.name} for further details.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
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
