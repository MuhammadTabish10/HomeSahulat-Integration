// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/models/review.dart';
import 'package:homesahulat_fyp/widget/build_review_item.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ServiceProviderProfileView extends StatefulWidget {
  const ServiceProviderProfileView({Key? key}) : super(key: key);

  @override
  _ServiceProviderProfileViewState createState() =>
      _ServiceProviderProfileViewState();
}

class _ServiceProviderProfileViewState
    extends State<ServiceProviderProfileView> {
  late List<Review> reviewList;
  late ServiceProvider serviceProvider;
  late String token;
  late bool isMounted;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    reviewList = [];
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
    _loadData();
  }

  Future<void> _loadData() async {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      serviceProvider = args['serviceProvider'] ?? '';
    } else {
      serviceProvider = {} as ServiceProvider;
    }

    token = Provider.of<TokenProvider>(context, listen: false).token;

    try {
      final reviews = await getAllReviews(serviceProvider.id, token);
      if (isMounted) {
        setState(() {
          reviewList = reviews;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading data: $e');
      if (isMounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<List<Review>> getAllReviews(
      int serviceProviderId, String token) async {
    String apiUrl = getAllReviewsByServiceProviderIdUrl(serviceProviderId);
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
        print('Data: $data');
        List<Review> reviewList =
            data.map((json) => Review.fromJson(json)).toList();
        print('reviews: $reviewList');
        return reviewList;
      } else {
        print('Failed to load reviews: ${response.statusCode}');
        print(response.body);
        return [];
      }
    } catch (e) {
      print('Error fetching Reviews: $e');
      return [];
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
        title: const Text('Service Provider Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                // Add a background image to the container
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/design.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Information Section
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 64.0,
                        backgroundImage: NetworkImage(
                          serviceProvider.user.profilePictureUrl ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      serviceProvider.user.name,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      serviceProvider.services.name,
                      style: const TextStyle(fontSize: 18.0),
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
                          onPressed: () async {
                            String phoneNumber =
                                'tel:${serviceProvider.user.phone}';
                            await launch(phoneNumber);

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

                    // Display fetched reviews
                    Expanded(
                      child: ListView.builder(
                        itemCount: reviewList.length,
                        itemBuilder: (context, index) {
                          final review = reviewList[index];
                          return buildReviewItem(
                            review.user
                                .name, // Assuming you have a name property in User
                            review.user.profilePictureUrl ??
                                '', // Assuming you have a profile picture URL in User
                            review.rating, // Assuming rating is a double
                            review.note,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
