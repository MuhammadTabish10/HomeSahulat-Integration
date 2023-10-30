import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/widget/build_review_item.dart';

class ServiceProviderProfileView extends StatefulWidget {
  const ServiceProviderProfileView({Key? key}) : super(key: key);

  @override
  _ServiceProviderProfileViewState createState() =>
      _ServiceProviderProfileViewState();
}

class _ServiceProviderProfileViewState
    extends State<ServiceProviderProfileView> {
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
        title: const Text('Service Provider Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Information Section
            Container(
              alignment: Alignment.center,
              child: const CircleAvatar(
                radius: 64.0,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Jamil Anwar',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Electrician',
              style: TextStyle(fontSize: 18.0),
            ),
            const Text(
              'Gulistan-e-Johar, Karachi',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 24.0),

            // Message and Call Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, chatRoute);
                  },
                  icon: const Icon(Icons.message),
                  label: const Text('Message'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle phone button press
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Phone'),
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            // Review Section
            const Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Individual User Reviews
            buildReviewItem(
                'John Doe', 'assets/user1.jpg', 4, 'Great service!'),
            buildReviewItem(
                'Jane Smith', 'assets/user2.jpg', 5, 'Very professional!'),
          ],
        ),
      ),
    );
  }
}
