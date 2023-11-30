// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';
import 'dart:convert';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:http/http.dart' as http;

class ServiceProviderView extends StatefulWidget {
  const ServiceProviderView({Key? key}) : super(key: key);

  @override
  _ServiceProviderViewState createState() => _ServiceProviderViewState();
}

class _ServiceProviderViewState extends State<ServiceProviderView> {
  late List<ServiceProvider> serviceProviderList = [];
  late String service;
  late String token;
  late String serviceName;
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
      serviceName = args['serviceName'] ?? '';
    } else {
      // Handle the case where arguments are null
      token = '';
      serviceName = '';
    }

    try {
      final providers = await getAllServiceProviders(serviceName, token);
      if (isMounted) {
        setState(() {
          serviceProviderList = providers;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<List<ServiceProvider>> getAllServiceProviders(
      String service, String token) async {
    String apiUrl = getAllServiceProvidersByServiceUrl(service);
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
        List<ServiceProvider> providers =
            data.map((json) => ServiceProvider.fromJson(json)).toList();
        return providers;
      } else {
        print('Failed to load service providers: ${response.statusCode}');
        print(response.body);
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
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
        title: const Text('Service Providers'),
        leadingWidth: 56.0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose the best service provider',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: serviceProviderList.length,
              itemBuilder: (context, index) {
                ServiceProvider provider = serviceProviderList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFB2DFDB),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Profile Picture
                      CircleAvatar(
                        radius: 64.0,
                        backgroundImage: NetworkImage(
                          provider.user.profilePictureUrl ?? '',
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.user.name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              provider.services.name,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${provider.totalExperience} Services | ${provider.totalRating} ratings',
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle book button press
                                      Navigator.pushNamed(
                                          context, bookingRoute);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: const Text('Book'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle view profile button press
                                      Navigator.pushNamed(
                                          context, serviceProviderProfileRoute);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: const Color(0xFF061C43),
                                    ),
                                    child: const Text(
                                      'View Profile',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
