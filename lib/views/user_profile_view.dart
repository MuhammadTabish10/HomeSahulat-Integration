// import 'package:flutter/material.dart';
// import 'package:homesahulat_fyp/models/user.dart';
// import 'package:homesahulat_fyp/utilities/full_screen_image.dart';
// import 'package:homesahulat_fyp/widget/build_profile_item.dart';
// import 'dart:convert';
// import 'package:homesahulat_fyp/constants/api_end_points.dart';
// import 'package:homesahulat_fyp/widget/custom_toast.dart';
// import 'package:http/http.dart' as http;
// import 'package:homesahulat_fyp/models/location.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// import '../config/token_provider.dart';

// class UserProfileView extends StatefulWidget {
//   const UserProfileView({Key? key}) : super(key: key);

//   @override
//   _UserProfileViewState createState() => _UserProfileViewState();
// }

// class _UserProfileViewState extends State<UserProfileView> {
//   late User user = User(name: '', password: '', phone: '', email: '');
//   late bool _isLoading;
//   late Location location = Location(
//     id: 0,
//     name: '',
//     address: '',
//     city: '',
//     state: '',
//     postalCode: 0,
//     country: '',
//     latitude: 0.0,
//     longitude: 0.0,
//     status: false,
//   );
//   late String token;
//   bool isMounted = false;

//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController postalCodeController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _isLoading = false;
//     token = Provider.of<TokenProvider>(context, listen: false).token;
//     isMounted = true;
//   }

//   @override
//   void dispose() {
//     isMounted = false;
//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     loadData();
//   }

//   Future<void> loadData() async {
//     try {
//       final loggedInUser = await getUser(token);
//       if (isMounted) {
//         setState(() {
//           user = loggedInUser;
//           location = user.location ??
//               Location(
//                 id: 0,
//                 name: '',
//                 address: '',
//                 city: '',
//                 state: '',
//                 postalCode: 0,
//                 country: '',
//                 latitude: 0.0,
//                 longitude: 0.0,
//                 status: false,
//               );
//         });
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   Future<User> getUser(String token) async {
//     String apiUrl = getLoggedInUserUrl;
//     final Uri uri = Uri.parse(apiUrl);

//     try {
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> userData = json.decode(response.body);
//         User user = User.fromJson(userData);
//         return user;
//       } else {
//         print('Failed to load logged in user: ${response.statusCode}');
//         return user;
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//       return user;
//     }
//   }

//   Future<void> updateLocation(int? id, String address, String city,
//       String state, String country, String postalCode) async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final response = await http.put(
//         Uri.parse(updateLocationUrl(id!)),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode({
//           'address': address,
//           'city': city,
//           'state': state,
//           'country': country,
//           'postalCode': postalCode
//         }),
//       );

//       if (response.statusCode == 200) {
//         Navigator.pop(context);
//         debugPrint('updated location successful');
//       } else {
//         final Map<String, dynamic> errorData = json.decode(response.body);

//         if (errorData.containsKey('address')) {
//           final String dateError = errorData['address'].toString();
//           CustomToast.showAlert(context, dateError);
//         } else if (errorData.containsKey('city')) {
//           final String dataError = errorData['city'].toString();
//           CustomToast.showAlert(context, dataError);
//         } else if (errorData.containsKey('state')) {
//           final String dataError = errorData['state'].toString();
//           CustomToast.showAlert(context, dataError);
//         } else if (errorData.containsKey('country')) {
//           final String dataError = errorData['country'].toString();
//           CustomToast.showAlert(context, dataError);
//         } else if (errorData.containsKey('postalCode')) {
//           final String dataError = errorData['postalCode'].toString();
//           CustomToast.showAlert(context, dataError);
//         } else {
//           // Display a generic error message for other errors
//           final String errorMessage = errorData['error'].toString();
//           CustomToast.showAlert(context, errorMessage);
//         }
//         debugPrint('Update failed: ${response.statusCode}');
//         debugPrint('Response Body: ${response.body}');
//       }
//     } catch (error) {
//       debugPrint('Error: $error');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           // Add a background image to the container
//           image: DecorationImage(
//             image: AssetImage('lib/assets/images/design.png'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.all(16.0),
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         FullScreenImage(user.profilePictureUrl ?? ''),
//                   ),
//                 );
//               },
//               child: Hero(
//                 tag: 'profile_image',
//                 child: Center(
//                   child: CircleAvatar(
//                     radius: 60.0,
//                     backgroundImage: NetworkImage(user.profilePictureUrl ?? ''),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             buildUserInfoCard(),
//             buildLocationCard(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildUserInfoCard() {
//     return Card(
//       elevation: 4.0,
//       margin: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               'User Information',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildProfileItem('Name', user.name),
//                 buildProfileItem('Email', user.email),
//                 buildProfileItem('First Name', user.firstName ?? ''),
//                 buildProfileItem('Last Name', user.lastName ?? ''),
//                 buildProfileItem('Phone', user.phone),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildLocationCard() {
//     return Card(
//       elevation: 4.0,
//       margin: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               'Location Information',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildLocationInfo(location),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   _showEditLocationBottomSheet(context);
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     const Color.fromARGB(255, 64, 173, 162),
//                   ),
//                 ),
//                 child: const Text(
//                   'Edit',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showEditLocationBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         // Set initial values for TextEditingControllers
//         addressController.text = location.address;
//         cityController.text = location.city;
//         stateController.text = location.state;
//         postalCodeController.text = location.postalCode.toString();
//         countryController.text = location.country;

//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: AnimationLimiter(
//             child: StatefulBuilder(
//               builder: (context, setState) {
//                 return Container(
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20.0),
//                       topRight: Radius.circular(20.0),
//                     ),
//                   ),
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: AnimationConfiguration.toStaggeredList(
//                       duration: const Duration(milliseconds: 375),
//                       childAnimationBuilder: (widget) => SlideAnimation(
//                         horizontalOffset: 50.0,
//                         child: FadeInAnimation(
//                           child: widget,
//                         ),
//                       ),
//                       children: [
//                         const Text(
//                           'Edit Location Information',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextField(
//                           controller: addressController,
//                           decoration:
//                               const InputDecoration(labelText: 'Address'),
//                           keyboardType: TextInputType.text,
//                         ),
//                         TextField(
//                           controller: cityController,
//                           decoration: const InputDecoration(labelText: 'City'),
//                           keyboardType: TextInputType.text,
//                         ),
//                         TextField(
//                           controller: stateController,
//                           decoration: const InputDecoration(labelText: 'State'),
//                           keyboardType: TextInputType.text,
//                         ),
//                         TextField(
//                           controller: postalCodeController,
//                           decoration:
//                               const InputDecoration(labelText: 'Postal Code'),
//                           keyboardType: TextInputType.number,
//                         ),
//                         TextField(
//                           controller: countryController,
//                           decoration:
//                               const InputDecoration(labelText: 'Country'),
//                           keyboardType: TextInputType.text,
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             // Update location
//                             await updateLocation(
//                               user.location?.id,
//                               addressController.text,
//                               cityController.text,
//                               stateController.text,
//                               countryController.text,
//                               postalCodeController.text,
//                             );

//                             // Refresh the user data
//                             await loadData();

//                             // Wait for a short duration to allow UI to update
//                             await Future.delayed(
//                                 const Duration(milliseconds: 500));

//                             Navigator.pop(context); // Close the bottom sheet
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                               const Color.fromARGB(255, 64, 173, 162),
//                             ),
//                           ),
//                           child: _isLoading
//                               ? const CircularProgressIndicator()
//                               : const Text(
//                                   'Update',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/models/role.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/models/location.dart';
import 'package:homesahulat_fyp/models/user.dart';
import 'package:homesahulat_fyp/utilities/full_screen_image.dart';
import 'package:homesahulat_fyp/widget/build_profile_item.dart';
import 'package:homesahulat_fyp/widget/custom_toast.dart';
import 'package:intl/intl.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  User user = User(email: '', name: '', password: '', phone: '');
  late bool _isLoading;
  Location location = Location(
    id: 0,
    address: '',
    city: '',
    state: '',
    postalCode: 0,
    country: '',
    latitude: 0.0,
    longitude: 0.0,
    status: false,
  );
  late String token;
  bool isMounted = false;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

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
      final loggedInUser = await getUser();
      if (isMounted) {
        setState(() {
          user = loggedInUser;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<User> getUser() async {
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
        return User.fromJson(userData);
      } else {
        debugPrint('Failed to load logged in user: ${response.statusCode}');
        debugPrint(response.body);
        return user;
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return user;
    }
  }

  Future<void> saveUser(
    int? id,
    DateTime? createdAt,
    String? deviceId,
    String? otp,
    bool? otpFlag,
    String? profilePictureUrl,
    bool? status,
    String name,
    String phone,
    String email,
    String password,
    List<Role>? roles,
    Location? location,
  ) async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl = updateUserUrl(id!);
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'id': id,
          'createdAt': createdAt != null
              ? DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt)
              : null,
          'deviceId': deviceId,
          'otp': otp,
          'otpFlag': otpFlag,
          'profilePictureUrl': profilePictureUrl,
          'status': status,
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'latitude': 0.0,
          'longitude': 0.0,
          'location': location != null ? {'id': location.id} : null,
          'roles': roles != null
              ? roles.map((role) => {'id': role.id}).toList()
              : null,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('user Location added successfully');
      } else {
        // Registration failed, handle the error
        CustomToast.showAlert(context, 'user Location addition Failed');
        debugPrint('user Location update failed: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error: $error');
    } finally {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  Future<void> updateLocation(int? id, String address, String city,
      String state, String country, String postalCode) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.put(
        Uri.parse(updateLocationUrl(id!)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'address': address,
          'city': city,
          'state': state,
          'country': country,
          'postalCode': postalCode
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Location? newLocation = Location.fromJson(responseData);

        // Update location in the state
        setState(() {
          location = newLocation;
        });

        Navigator.pop(context);
        debugPrint('updated location successful');
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);

        if (errorData.containsKey('address')) {
          final String dateError = errorData['address'].toString();
          CustomToast.showAlert(context, dateError);
        } else if (errorData.containsKey('city')) {
          final String dataError = errorData['city'].toString();
          CustomToast.showAlert(context, dataError);
        } else if (errorData.containsKey('state')) {
          final String dataError = errorData['state'].toString();
          CustomToast.showAlert(context, dataError);
        } else if (errorData.containsKey('country')) {
          final String dataError = errorData['country'].toString();
          CustomToast.showAlert(context, dataError);
        } else if (errorData.containsKey('postalCode')) {
          final String dataError = errorData['postalCode'].toString();
          CustomToast.showAlert(context, dataError);
        } else {
          // Display a generic error message for other errors
          final String errorMessage = errorData['error'].toString();
          CustomToast.showAlert(context, errorMessage);
        }
        debugPrint('Update failed: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> addLocation(String address, String city, String state,
      String country, String postalCode) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(addLocationUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'address': address,
          'city': city,
          'state': state,
          'country': country,
          'postalCode': postalCode
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Location? newLocation = Location.fromJson(responseData);

        // Update location in the state
        setState(() {
          location = newLocation;
        });

        User updatedUser = await getUser();
        updatedUser.location = newLocation;

        await saveUser(
          updatedUser.id,
          updatedUser.createdAt,
          updatedUser.deviceId,
          updatedUser.otp,
          updatedUser.otpFlag,
          updatedUser.profilePictureUrl,
          updatedUser.status,
          updatedUser.name,
          updatedUser.phone,
          updatedUser.email,
          updatedUser.password,
          updatedUser.roles,
          updatedUser.location,
        );

        // Refresh the user data
        await loadData();

        // Wait for a short duration to allow UI to update
        await Future.delayed(const Duration(milliseconds: 500));

        Navigator.pop(context);
        debugPrint('Added location successfully');
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);

        if (errorData.containsKey('address')) {
          final String dateError = errorData['address'].toString();
          CustomToast.showAlert(context, dateError);
        } else if (errorData.containsKey('city')) {
          final String dataError = errorData['city'].toString();
          CustomToast.showAlert(context, dataError);
        } else if (errorData.containsKey('state')) {
          final String dataError = errorData['state'].toString();
          CustomToast.showAlert(context, dataError);
        } else if (errorData.containsKey('country')) {
          final String dataError = errorData['country'].toString();
          CustomToast.showAlert(context, dataError);
        } else if (errorData.containsKey('postalCode')) {
          final String dataError = errorData['postalCode'].toString();
          CustomToast.showAlert(context, dataError);
        } else {
          // Display a generic error message for other errors
          final String errorMessage = errorData['error'].toString();
          CustomToast.showAlert(context, errorMessage);
        }
        debugPrint('Addition failed: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error: $error');
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
        decoration: const BoxDecoration(
          // Add a background image to the container
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImage(user.profilePictureUrl ?? ''),
                  ),
                );
              },
              child: Hero(
                tag: 'profile_image',
                child: Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(user.profilePictureUrl ?? ''),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            buildUserInfoCard(),
            buildLocationCard(),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfoCard() {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'User Information',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileItem('Name', user.name),
                buildProfileItem('Email', user.email),
                buildProfileItem('Phone', user.phone),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocationCard() {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Location Information',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.location != null && user.location!.id != null)
                  buildLocationInfo(user.location!),
                if (user.location == null || user.location!.id == null)
                  const Text(
                    'No location information available',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          if (user.location == null || user.location!.id == null)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showAddLocationBottomSheet(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 64, 173, 162),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Add Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          if (user.location != null && user.location!.id != null)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showEditLocationBottomSheet(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 64, 173, 162),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showAddLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        // Set initial values for TextEditingControllers
        addressController.text = '';
        cityController.text = '';
        stateController.text = '';
        postalCodeController.text = '';
        countryController.text = '';

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AnimationLimiter(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        const Text(
                          'Add Location Information',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: addressController,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: cityController,
                          decoration: const InputDecoration(labelText: 'City'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: stateController,
                          decoration: const InputDecoration(labelText: 'State'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: postalCodeController,
                          decoration:
                              const InputDecoration(labelText: 'Postal Code'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: countryController,
                          decoration:
                              const InputDecoration(labelText: 'Country'),
                          keyboardType: TextInputType.text,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Add location
                            await addLocation(
                              addressController.text,
                              cityController.text,
                              stateController.text,
                              countryController.text,
                              postalCodeController.text,
                            );

                            // Refresh the user data
                            await loadData();

                            // Wait for a short duration to allow UI to update
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            Navigator.pop(context); // Close the bottom sheet
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 64, 173, 162),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showEditLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        // Set initial values for TextEditingControllers
        addressController.text = location!.address;
        cityController.text = location!.city;
        stateController.text = location!.state;
        postalCodeController.text = location!.postalCode.toString();
        countryController.text = location!.country;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AnimationLimiter(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        const Text(
                          'Edit Location Information',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: addressController,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: cityController,
                          decoration: const InputDecoration(labelText: 'City'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: stateController,
                          decoration: const InputDecoration(labelText: 'State'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: postalCodeController,
                          decoration:
                              const InputDecoration(labelText: 'Postal Code'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: countryController,
                          decoration:
                              const InputDecoration(labelText: 'Country'),
                          keyboardType: TextInputType.text,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Update location
                            await updateLocation(
                              user.location?.id,
                              addressController.text,
                              cityController.text,
                              stateController.text,
                              countryController.text,
                              postalCodeController.text,
                            );

                            // Refresh the user data
                            await loadData();

                            // Wait for a short duration to allow UI to update
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            Navigator.pop(context); // Close the bottom sheet
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 64, 173, 162),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
