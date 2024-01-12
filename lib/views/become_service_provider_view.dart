import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/models/service_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/models/location.dart';
import 'package:homesahulat_fyp/models/services.dart';
import 'package:homesahulat_fyp/models/user.dart';
import 'package:homesahulat_fyp/utilities/full_screen_image.dart';
import 'package:homesahulat_fyp/widget/build_profile_item.dart';
import 'package:homesahulat_fyp/widget/custom_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class BecomeServiceProviderView extends StatefulWidget {
  const BecomeServiceProviderView({Key? key}) : super(key: key);

  @override
  _BecomeServiceProviderViewState createState() =>
      _BecomeServiceProviderViewState();
}

class _BecomeServiceProviderViewState extends State<BecomeServiceProviderView> {
  List<String> servicesList = ['Plumber', 'Electrician', 'Carpenter'];
  late User user;
  late ServiceProvider serviceProvider;
  late Services service;
  late String token;
  bool _isLoading = false;
  String? selectedService;
  bool haveShop = false;
  String? imageName;

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController hourlyPriceController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController totalExperienceController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    user = User(name: '', password: '', phone: '', email: '');
    service = Services(name: '');
    serviceProvider = ServiceProvider(
        id: 0,
        cnicNo: '',
        description: '',
        hourlyPrice: 0,
        totalExperience: 0,
        haveShop: false,
        user: user,
        services: service);
    token = Provider.of<TokenProvider>(context, listen: false).token;
    loadData();
  }

  Future<void> loadData() async {
    try {
      final loggedInUser = await getUser(token);
      setState(() {
        user = loggedInUser;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
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
        debugPrint('Failed to load logged in user: ${response.statusCode}');
        return user;
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return user;
    }
  }

  Future<ServiceProvider> getServiceProviderByUserId(int id) async {
    String apiUrl = getServiceProviderByUserIdUrl(id);
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
        final Map<String, dynamic> data = json.decode(response.body);
        ServiceProvider serviceProvider = ServiceProvider.fromJson(data);
        return serviceProvider;
      } else {
        debugPrint('Failed to load serviceProvider: ${response.statusCode}');
        return serviceProvider;
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return serviceProvider;
    }
  }

  Future<Services> getServiceByName(String name) async {
    String apiUrl = getServiceByNameUrl(name);
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
        final Map<String, dynamic> data = json.decode(response.body);
        Services service = Services.fromJson(data);
        return service;
      } else {
        debugPrint('Failed to load logged in service: ${response.statusCode}');
        return service;
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return service;
    }
  }

  Future<void> createServiceProvider(
      String description,
      String cnicNo,
      double hourlyPrice,
      double totalExperience,
      bool haveShop,
      User user,
      Services services) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(createServiceProviderUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'description': description,
          'cnicNo': cnicNo,
          'hourlyPrice': hourlyPrice,
          'totalExperience': totalExperience,
          'haveShop': haveShop,
          'user': {'id': user.id},
          'services': {'id': services.id},
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Service Provider creation request successful');
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);

        if (errorData.containsKey('description')) {
          final String descriptionError = errorData['description'].toString();
          CustomToast.showAlert(context, descriptionError);
        } else if (errorData.containsKey('hourlyPrice')) {
          final String hourlyPriceError = errorData['hourlyPrice'].toString();
          CustomToast.showAlert(context, hourlyPriceError);
        } else if (errorData.containsKey('totalExperience')) {
          final String totalExperienceError =
              errorData['totalExperience'].toString();
          CustomToast.showAlert(context, totalExperienceError);
        } else if (errorData.containsKey('haveShop')) {
          final String haveShopError = errorData['haveShop'].toString();
          CustomToast.showAlert(context, haveShopError);
        } else if (errorData.containsKey('user')) {
          final String userError = errorData['user'].toString();
          CustomToast.showAlert(context, userError);
        } else if (errorData.containsKey('services')) {
          final String servicesError = errorData['services'].toString();
          CustomToast.showAlert(context, servicesError);
        } else if (errorData.containsKey('attachment')) {
          final String attachmentError = errorData['attachment'].toString();
          CustomToast.showAlert(context, attachmentError);
        } else if (errorData.containsKey('cnicNo')) {
          final String cnicError = errorData['cnicNo'].toString();
          CustomToast.showAlert(context, cnicError);
        } else if (errorData.containsKey('ServiceProvider already exists')) {
          final String error = errorData['error'].toString();
          CustomToast.showAlert(context, error);
        } else {
          // Display a generic error message for other errors
          final String errorMessage = errorData['error'].toString();
          CustomToast.showAlert(context, errorMessage);
        }
        debugPrint('ServiceProvider Creation failed: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error: $error');
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false when login is complete
      });
    }
  }

  void _showEditDetailsOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        bool localHaveShop = haveShop; // Local variable for the checkbox

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
                        // Form fields for additional details
                        TextField(
                          controller: descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        TextField(
                          controller: cnicController,
                          decoration:
                              const InputDecoration(labelText: 'Cnic No'),
                        ),
                        TextField(
                          controller: hourlyPriceController,
                          decoration: const InputDecoration(
                              labelText: 'Hourly Price in Rs'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: totalExperienceController,
                          decoration: const InputDecoration(
                              labelText: 'Total Experience in Years'),
                          keyboardType: TextInputType.number,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedService,
                          decoration:
                              const InputDecoration(labelText: 'Service Type'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedService = newValue;
                            });
                          },
                          items: servicesList
                              .map<DropdownMenuItem<String>>((String service) {
                            return DropdownMenuItem<String>(
                              value: service,
                              child: Text(service),
                            );
                          }).toList(),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: localHaveShop,
                              onChanged: (value) {
                                setState(() {
                                  localHaveShop = value ?? false;
                                });
                              },
                            ),
                            const Text('Have Shop'),
                          ],
                        ),

                        // Submit button
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              // Call the function to get service by name
                              Services service =
                                  await getServiceByName(selectedService!);

                              // Call the function to create a service provider
                              await createServiceProvider(
                                descriptionController.text,
                                cnicController.text,
                                double.parse(hourlyPriceController.text),
                                double.parse(totalExperienceController.text),
                                localHaveShop,
                                user,
                                service,
                              );
                              _showImageUploadDialog();
                            } catch (error) {
                              // Handle errors during API calls
                              debugPrint('Error: $error');
                            }
                          },
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Submit'),
                        )
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            // Background Image
            ListView(
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
                        backgroundImage:
                            NetworkImage(user.profilePictureUrl ?? ''),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                buildProfileItem('Name', user.name),
                buildProfileItem('Email', user.email),
                buildProfileItem('Phone', user.phone),
                buildLocationInfo(user.location ??
                    Location(
                      id: 0,
                      address: '',
                      city: '',
                      state: '',
                      postalCode: 0,
                      country: '',
                      latitude: 0.0,
                      longitude: 0.0,
                      status: false,
                    )),
                // Button to edit additional details
                ElevatedButton(
                  onPressed: _showEditDetailsOverlay,
                  child: const Text('Add Additional Details'),
                ),
              ],
            ),

            // Overlay Form
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showImageUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isUploading = false;
        XFile? pickedImage;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Upload Cnic Image'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final XFile? pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        debugPrint('Image Path: ${pickedFile.path}');
                        setState(() {
                          pickedImage = pickedFile;
                          imageName = pickedFile.name;
                        });
                      }
                    },
                    child: const Text('Pick Cnic'),
                  ),
                  // Display the picked image's name
                  if (imageName != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8.0),
                          Text('$imageName'),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: pickedImage == null
                        ? null // Disable the button if no image is picked
                        : () async {
                            try {
                              setState(() {
                                isUploading = true;
                              });

                              // Assuming getServiceProviderByUserId returns a ServiceProvider
                              serviceProvider =
                                  await getServiceProviderByUserId(user.id!);

                              // Create a multipart request
                              var request = http.MultipartRequest(
                                'POST',
                                Uri.parse(
                                    uploadCnicImageUrl(serviceProvider.id)),
                              );

                              // Add the image file to the request
                              request.files.add(
                                await http.MultipartFile.fromPath(
                                  'file',
                                  pickedImage!.path,
                                ),
                              );

                              // Send the request
                              var response = await request.send();

                              // Check the response status
                              if (response.statusCode == 200) {
                                debugPrint('Image uploaded successfully');
                                // Handle successful upload, if needed
                                CustomToast.showAlert(
                                    context, "ServiceProvider Request Created.");
                              } else {
                                debugPrint(
                                    'Failed to upload image. Status code: ${response.statusCode}');
                                CustomToast.showAlert(
                                    context, "Failed to upload image.");
                              }

                              setState(() {
                                isUploading = false;
                              });
                            } catch (error) {
                              debugPrint('Error uploading image: $error');
                            }
                          },
                    child: isUploading
                        ? const CircularProgressIndicator()
                        : const Text('Upload'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
