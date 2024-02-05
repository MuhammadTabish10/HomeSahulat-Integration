import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../constants/routes.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';

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
    token = Provider.of<TokenProvider>(context, listen: false).token;
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
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      serviceProvider = args['serviceProvider'] ?? '';
    } else {
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
            Navigator.of(context).pushNamedAndRemoveUntil(
              homeRoute,
              (route) => false,
            );
          },
        ),
        title: const Text('Booking Confirmation'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(
                          serviceProvider.user.profilePictureUrl ?? ''),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      serviceProvider.user.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You have successfully booked ${serviceProvider.user.name} to fix your problem. Get in touch with ${serviceProvider.user.name} for further details.',
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            String roomId = const Uuid().v4();
                            Navigator.pushNamed(
                              context,
                              chatRoute,
                              arguments: {'roomId': roomId},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF3ECAB0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                          icon: const Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Message',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              serviceProviderProfileRoute,
                              arguments: {'serviceProvider': serviceProvider},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF061C43),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                          icon: const Icon(Icons.person, color: Colors.white),
                          label: const Text(
                            'View Profile',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          homeRoute,
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
