import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
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
  late List<SpecialBooking> bookingList = [];
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
      final loggedInServiceProvider = await getServiceProvider();
      final bookings = await getBookingByServiceProvider(
          loggedInServiceProvider.id, "Pending");
      setState(() {
        bookingList = bookings;
        serviceProvider = loggedInServiceProvider;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<ServiceProvider> getServiceProvider() async {
    String apiUrl = getLoggedInServiceProviderUrl;
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
        final Map<String, dynamic> serviceProviderData =
            json.decode(response.body);
        ServiceProvider serviceProvider =
            ServiceProvider.fromJson(serviceProviderData);
        return serviceProvider;
      } else {
        debugPrint(
            'Failed to load logged in serviceProvider: ${response.statusCode}');
        return serviceProvider;
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return serviceProvider;
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

  Future<List<SpecialBooking>> getBookingByServiceProvider(
      int id, String status) async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl = getAllBookingsByServiceProviderIdUrl(id, status);
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
            const Text(
              'Incoming Booking Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : (bookingList.isEmpty
                    ? const Center(child: Text('No incoming bookings.'))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: bookingList.length,
                          itemBuilder: (context, index) {
                            SpecialBooking booking = bookingList[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      booking.user.profilePictureUrl ?? ''),
                                ),
                                title: Text(
                                    '${booking.user.name} - ${booking.appointmentDate?.toString().split(' ')[0]}'),
                                subtitle: Text(
                                    '${booking.appointmentTime?.format(context)}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () async {
                                        // Implement accept booking logic
                                        updateBookingStatus(
                                            booking.id, 'Confirmed');
                                        await loadData();
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        // Implement reject booking logic
                                        updateBookingStatus(
                                            booking.id, 'Rejected');
                                        await loadData();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
