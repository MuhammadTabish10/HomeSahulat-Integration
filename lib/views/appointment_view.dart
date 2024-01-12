import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/models/special_booking.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late List<SpecialBooking> bookingList = [];
  bool isMounted = false;
  late bool _isLoading;
  late String token;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
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
    try {
      // Set loading to true when API call starts
      setState(() {
        _isLoading = true;
      });

      final bookings = await getAllBookings();
      if (isMounted) {
        setState(() {
          bookingList = bookings;
        });
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      // Set loading to false when API call completes (whether successful or not)
      if (isMounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<List<SpecialBooking>> getAllBookings() async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl = getBookingsByLoggedInUserUrl;
    final Uri uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);

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
      debugPrint('Error fetching data: $e');
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isLoading) const CircularProgressIndicator(),
                      const SizedBox(height: 16), // Add spacing after loader
                      _buildSection(
                        'Confirmed Appointments',
                        getBookingsByStatus('Confirmed'),
                      ),
                      const SizedBox(height: 16),
                      _buildSection(
                        'Pending Appointments',
                        getBookingsByStatus('Pending'),
                      ),
                      const SizedBox(height: 16),
                      _buildSection(
                        'Rejected Appointments',
                        getBookingsByStatus('Rejected'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<SpecialBooking> getBookingsByStatus(String status) {
    return bookingList
        .where((booking) => booking.bookingStatus == status)
        .toList();
  }

  Widget _buildSection(String title, List<SpecialBooking> bookings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        bookings.isEmpty
            ? const Text('No appointments in this category.')
            : Column(
                children: bookings
                    .map((booking) => _buildAppointmentCard(booking))
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildAppointmentCard(SpecialBooking booking) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 34.0,
              backgroundImage: NetworkImage('https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg'),
            ),
            const SizedBox(width: 16), // Add spacing between CircleAvatar and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${_formatDateTime(booking.appointmentDate!)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Time: ${_formatTime(booking.appointmentTime!)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: _buildStatusChip(booking.bookingStatus),
      ),
    );
  }

  Widget _buildStatusChip(String? status) {
    Color chipColor;
    switch (status) {
      case 'Confirmed':
        chipColor = Colors.green;
        break;
      case 'Pending':
        chipColor = Colors.orange;
        break;
      case 'Rejected':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      backgroundColor: chipColor,
      label: Text(
        status!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(TimeOfDay time) {
    final parsedTime = time;
    final formatter = DateFormat.jm(); // Adjust the time format as needed
    return formatter
        .format(DateTime(2023, 1, 1, parsedTime.hour, parsedTime.minute));
  }
}
