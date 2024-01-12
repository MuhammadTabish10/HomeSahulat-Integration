import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/models/review.dart';
import 'package:homesahulat_fyp/widget/build_review_item.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';
import 'package:homesahulat_fyp/models/special_booking.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ServiceProviderHomeScreen extends StatefulWidget {
  const ServiceProviderHomeScreen({Key? key}) : super(key: key);

  @override
  State<ServiceProviderHomeScreen> createState() =>
      _ServiceProviderHomeScreenState();
}

class _ServiceProviderHomeScreenState extends State<ServiceProviderHomeScreen> {
  late ServiceProvider serviceProvider;
  late bool _isLoading;
  late String token;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    token = context.read<TokenProvider>().token;
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final bookings = await getBookingByServiceProvider(serviceProvider.id);
      setState(() {
        // incomingBookings = bookings;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> updateBookingStatus(int id, String status) async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = updateBookingStatusUrl(id, status);

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Booking status updated successfully');
      } else {
        debugPrint(
            'Failed to update booking status. Status code: ${response.statusCode}');
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint('Error updating booking status: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<SpecialBooking>> getBookingByServiceProvider(int id) async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl = getAllBookingsByServiceProviderIdUrl(id);
    final Uri uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<SpecialBooking> bookings =
            data.map((json) => SpecialBooking.fromJson(json)).toList();
        return bookings;
      } else {
        debugPrint('Failed to load bookings: ${response.statusCode}');
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching data of bookings: $e');
      return [];
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Incoming Booking Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Change this to the actual number of bookings
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://placekitten.com/100/100'), // Replace with actual user profile picture URL
                      ),
                      title: Text('John Doe - 2023-01-01'),
                      subtitle: Text('10:00 AM'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.green, // Set the color to green
                            ),
                            onPressed: () {
                              // Implement accept booking logic
                              print('Booking accepted');
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.red, // Set the color to red
                            ),
                            onPressed: () {
                              // Implement reject booking logic
                              print('Booking rejected');
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

