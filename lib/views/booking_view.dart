import 'package:flutter/material.dart';
import '../constants/routes.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  // Form fields
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Time slots
  List<String> timeSlots = [
    '11:30 AM - 12:30 PM',
    '1:00 PM - 2:00 PM',
    '2:30 PM - 3:30 PM',
    // Add more time slots as needed
  ];

  String selectedTimeSlot = '';

  // Schedule options
  List<String> scheduleOptions = [
    '12 Apr 23',
    '13 Apr 23',
    '14 Apr 23',
    // Add more options as needed
  ];

  String selectedScheduleOption = '';

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
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
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
              const SizedBox(height: 10),
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
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Schedule your request',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Generate schedule option cards here
              ListView.builder(
                shrinkWrap: true,
                itemCount: scheduleOptions.length,
                itemBuilder: (context, index) {
                  return ScheduleOptionCard(
                    option: scheduleOptions[index],
                    isSelected:
                        scheduleOptions[index] == selectedScheduleOption,
                    onSelect: () {
                      setState(() {
                        selectedScheduleOption = scheduleOptions[index];
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select time slot',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Generate time slot cards here
              ListView.builder(
                shrinkWrap: true,
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return TimeSlotCard(
                    timeSlot: timeSlots[index],
                    isSelected: timeSlots[index] == selectedTimeSlot,
                    onSelect: () {
                      setState(() {
                        selectedTimeSlot = timeSlots[index];
                      });
                    },
                  );
                },
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
            onPressed: () {
              // Handle "Book Now" button press
              Navigator.pushNamed(context, bookingConfirmedRoute);
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
