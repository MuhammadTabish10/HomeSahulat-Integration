// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';
import '../constants/routes.dart';
import 'package:homesahulat_fyp/models/user.dart';
import 'dart:convert';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:intl/intl.dart';
import 'package:homesahulat_fyp/widget/custom_toast.dart';
import 'package:http/http.dart' as http;

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  late User user = User(name: '', password: '', phone: '');
  late ServiceProvider serviceProvider;
  late String token;
  bool isMounted = false;
  late bool _isLoading;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // Form fields
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

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
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      token = args['token'] ?? '';
      serviceProvider = args['serviceProvider'] ?? '';
    } else {
      token = '';
      serviceProvider = {} as ServiceProvider;
    }

    try {
      final loggedInUser = await getUser(token);
      if (isMounted) {
        setState(() {
          user = loggedInUser;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    // Set initial values for controllers
    descriptionController.text = '';
    addressController.text = user.location?.address ?? '';
    cityController.text = user.location?.city ?? '';
  }

  Future<User> getUser(String token) async {
    String apiUrl = getLoggedInUserUrl;
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
        final Map<String, dynamic> userData = json.decode(response.body);
        User user = User.fromJson(userData);
        return user;
      } else {
        print('Failed to load logged in user: ${response.statusCode}');
        return user;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return user;
    }
  }

  Future<void> book(DateTime date, TimeOfDay time,
      ServiceProvider serviceProvider, User user) async {
    setState(() {
      _isLoading = true; // Set loading to true when login starts
    });
    print('Formatted Date: ${DateFormat('yyyy-MM-dd').format(date)}');
    print('Formatted Time: ${DateFormat('HH:mm:ss').format(DateTime(2023, 1, 1, time.hour, time.minute))}');

    try {
      final response = await http.post(
        Uri.parse(bookUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'appointmentDate': DateFormat('yyyy-MM-dd')
              .format(date), // Convert DateTime to string
          'appointmentTime': DateFormat('HH:mm:ss').format(DateTime(
              2023,
              1,
              1,
              time.hour,
              time.minute)), // Assuming TimeOfDay has a suitable conversion method
          'user': user.toJson(), // Assuming User has a toJson method
          'serviceProvider': serviceProvider.toJson()
        }),
      );

      if (response.statusCode == 200) {
        // Login successful, extract user token from the response
        final Map<String, dynamic> responseData = json.decode(response.body);
        Navigator.of(context).pushNamedAndRemoveUntil(
          bookingConfirmedRoute,
          (route) => false,
          arguments: {'token': token},
        );

        print('Booking successful');
      } else {
        // Login failed, handle the error
        final Map<String, dynamic> errorData = json.decode(response.body);

        if (errorData.containsKey('appointmentDate')) {
          // If the error is related to the appointmentDate, display the appointmentDate error
          final String dateError = errorData['appointmentDate'].toString();
          CustomToast.showAlert(context, dateError);
        } else if (errorData.containsKey('appointmentTime')) {
          // If the error is related to the appointmentTime, display the appointmentTime error
          final String timeError = errorData['appointmentTime'].toString();
          CustomToast.showAlert(context, timeError);
        } else {
          // Display a generic error message for other errors
          final String errorMessage = errorData['error'].toString();
          CustomToast.showAlert(context, errorMessage);
        }

        print('Booking failed: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      // Handle network or API errors
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false when login is complete
      });
    }
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
    return selectedTime;
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
        title: const Text('Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please further describe your problem',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              const Text(
                'Schedule your request',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  'Selected Date: ${DateFormat('dd-MM-yyyy').format(selectedDate)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  'Selected Time: ${selectedTime.format(context)}',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              // Handle "Book Now" button press
              await book(selectedDate, selectedTime, serviceProvider, user);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 64, 173, 162)),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleOptionCard extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onSelect;

  const ScheduleOptionCard({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        tileColor: isSelected ? const Color.fromARGB(255, 64, 173, 162) : null,
        onTap: onSelect,
      ),
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  final String timeSlot;
  final bool isSelected;
  final VoidCallback onSelect;

  const TimeSlotCard({
    Key? key,
    required this.timeSlot,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          timeSlot,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        tileColor: isSelected ? const Color.fromARGB(255, 64, 173, 162) : null,
        onTap: onSelect,
      ),
    );
  }
}
