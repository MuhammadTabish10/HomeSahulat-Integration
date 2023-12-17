// // ignore_for_file: use_build_context_synchronously, avoid_print

// import 'dart:convert';
// import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
// import 'package:flutter/material.dart';
// import 'package:homesahulat_fyp/constants/routes.dart';
// import 'package:homesahulat_fyp/constants/api_end_points.dart';
// import 'package:homesahulat_fyp/widget/custom_toast.dart';
// // import 'package:homesahulat_fyp/service/device_id_provider.dart';
// import 'package:http/http.dart' as http;

// class RegisterView extends StatefulWidget {
//   const RegisterView({Key? key}) : super(key: key);

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   late final TextEditingController _name;
//   late final TextEditingController _phoneNumber;
//   late final TextEditingController _password;
//   bool _obscureText = true;
//   String deviceId = '';
//   late ProgressDialog _progressDialog;

//   @override
//   void initState() {
//     _name = TextEditingController();
//     _phoneNumber = TextEditingController();
//     _password = TextEditingController();
//     _progressDialog = ProgressDialog(context);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _name.dispose();
//     _phoneNumber.dispose();
//     _password.dispose();
//     super.dispose();
//   }

//   Future<void> registerUser(String name, String phone, String password) async {
//     await _progressDialog.show();
//     String apiUrl = signUpUrl;
//     // deviceId = (await DeviceIdProvider().getId())!;
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'name': name,
//           'phone': phone,
//           'password': password,
//           // 'deviceId': "deviceId"
//         }),
//       );

//       if (response.statusCode == 200) {
//         // Registration successful, extract user ID from the response
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         String userId = responseData['id'].toString();

//         _progressDialog.hide();
//         Navigator.of(context).pushNamedAndRemoveUntil(
//           otpVerificationRoute,
//           (route) => false,
//           arguments: userId,
//         );

//         print('Registration successful');
//       } else {
//         // Registration failed, handle the error
//         _progressDialog.hide();
//         CustomToast.showAlert(context, 'Registration Failed');
//         print('Registration failed: ${response.statusCode}');
//         print('Response Body: ${response.body}');
//       }
//     } catch (error) {
//       // Handle network or API errors
//       _progressDialog.hide();
//       print('Error: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: [
//           const SizedBox(height: 50),
//           Image.asset(
//             'lib/assets/images/logo.png',
//             width: 200,
//             height: 200,
//           ),
//           const SizedBox(height: 50),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: TextField(
//               controller: _name,
//               autocorrect: false,
//               keyboardType:
//                   TextInputType.name, // Set input type to phone number
//               decoration: const InputDecoration(
//                 hintText: 'Enter your name',
//                 border: InputBorder.none,
//                 suffixIcon: Icon(Icons.account_circle),
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: TextField(
//               controller: _phoneNumber,
//               autocorrect: false,
//               keyboardType:
//                   TextInputType.phone, // Set input type to phone number
//               decoration: const InputDecoration(
//                 hintText: 'Enter your phone number',
//                 border: InputBorder.none,
//                 suffixIcon: Icon(Icons.phone),
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: TextField(
//               controller: _password,
//               obscureText: _obscureText,
//               enableSuggestions: false,
//               autocorrect: false,
//               decoration: InputDecoration(
//                 hintText: 'Enter your password',
//                 border: InputBorder.none,
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _obscureText = !_obscureText;
//                     });
//                   },
//                   child: Icon(
//                     _obscureText ? Icons.visibility : Icons.visibility_off,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 64, 173, 162),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: TextButton(
//               onPressed: () async {
//                 // Get the phone number and password from text controllers
//                 String phone = _phoneNumber.text;
//                 String password = _password.text;
//                 String name = _name.text;

//                 // Call the registerUser function with phone and password
//                 registerUser(name, phone, password);
//               },
//               child: const Text(
//                 'Register',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           TextButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .pushNamedAndRemoveUntil(loginRoute, (route) => false);
//               },
//               child: const Text('Already Registered? Login here!')),
//         ],
//       ),
//     ));
//   }
// }

// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/widget/custom_toast.dart';
// import 'package:homesahulat_fyp/service/device_id_provider.dart';
import 'package:http/http.dart' as http;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>  {
  late final TextEditingController _name;
  late final TextEditingController _phoneNumber;
  late final TextEditingController _password;
  bool _obscureText = true;
  String deviceId = '';
  late bool _isLoading;

  @override
  void initState() {
    _name = TextEditingController();
    _phoneNumber = TextEditingController();
    _password = TextEditingController();
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _phoneNumber.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> registerUser(String name, String phone, String password) async {
    setState(() {
      _isLoading = true; // Set loading to true when registration starts
    });

    String apiUrl = signUpUrl;
    // deviceId = (await DeviceIdProvider().getId())!;
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'phone': phone,
          'password': password,
          // 'deviceId': "deviceId"
        }),
      );

      if (response.statusCode == 200) {
        // Registration successful, extract user ID from the response
        final Map<String, dynamic> responseData = json.decode(response.body);
        String userId = responseData['id'].toString();

        Navigator.of(context).pushNamedAndRemoveUntil(
          otpVerificationRoute,
          (route) => false,
          arguments: userId,
        );

        print('Registration successful');
      } else {
        // Registration failed, handle the error
        CustomToast.showAlert(context, 'Registration Failed');
        print('Registration failed: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      // Handle network or API errors
      print('Error: $error');
    } finally {
      setState(
        () {
          _isLoading = false; // Set loading to false when login is complete
        },
      );
    }}

    //   @override
    //   Widget build(BuildContext context) {
    //     double screenWidth = MediaQuery.of(context).size.width;

    //     return Scaffold(
    //         body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const SizedBox(height: 50),
    //           Image.asset(
    //             'lib/assets/images/logo.png',
    //             width: 200,
    //             height: 200,
    //           ),
    //           const SizedBox(height: 50),
    //           Container(
    //             decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.circular(5.0),
    //             ),
    //             margin:
    //                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: TextField(
    //               controller: _name,
    //               autocorrect: false,
    //               keyboardType:
    //                   TextInputType.name, // Set input type to phone number
    //               decoration: const InputDecoration(
    //                 hintText: 'Enter your name',
    //                 border: InputBorder.none,
    //                 suffixIcon: Icon(Icons.account_circle),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.circular(5.0),
    //             ),
    //             margin:
    //                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: TextField(
    //               controller: _phoneNumber,
    //               autocorrect: false,
    //               keyboardType:
    //                   TextInputType.phone, // Set input type to phone number
    //               decoration: const InputDecoration(
    //                 hintText: 'Enter your phone number',
    //                 border: InputBorder.none,
    //                 suffixIcon: Icon(Icons.phone),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.circular(5.0),
    //             ),
    //             margin:
    //                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: TextField(
    //               controller: _password,
    //               obscureText: _obscureText,
    //               enableSuggestions: false,
    //               autocorrect: false,
    //               decoration: InputDecoration(
    //                 hintText: 'Enter your password',
    //                 border: InputBorder.none,
    //                 suffixIcon: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       _obscureText = !_obscureText;
    //                     });
    //                   },
    //                   child: Icon(
    //                     _obscureText ? Icons.visibility : Icons.visibility_off,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: double.infinity,
    //             margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
    //             decoration: BoxDecoration(
    //               color: const Color.fromARGB(255, 64, 173, 162),
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             child: TextButton(
    //               onPressed: () async {
    //                 // Get the phone number and password from text controllers
    //                 String phone = _phoneNumber.text;
    //                 String password = _password.text;
    //                 String name = _name.text;

    //                 // Call the registerUser function with phone and password
    //                 registerUser(name, phone, password);
    //               },
    //               child: const Text(
    //                 'Register',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.of(context)
    //                     .pushNamedAndRemoveUntil(loginRoute, (route) => false);
    //               },
    //               child: const Text('Already Registered? Login here!')),
    //         ],
    //       ),
    //     ));
    //   }
    // }

    @override
    Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            // Add a background image to the container
            image: DecorationImage(
              image: AssetImage('lib/assets/images/design.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(left: 35, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _name,
                  autocorrect: false,
                  keyboardType:
                      TextInputType.name, // Set input type to phone number
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.account_circle),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _phoneNumber,
                  autocorrect: false,
                  keyboardType:
                      TextInputType.phone, // Set input type to phone number
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _password,
                  obscureText: _obscureText,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0), // Add margin as needed
                child: AnimatedOpacity(
                  opacity: _isLoading ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 16, bottom: 16), // Add margin to control spacing
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: screenWidth /
                      2, // Set the width to half of the screen width
                  margin: const EdgeInsets.only(top: 0, right: 30),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 64, 173, 162),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      String phone = _phoneNumber.text;
                      String password = _password.text;
                      String name = _name.text;

                      // Call the registerUser function with phone and password
                      registerUser(name, phone, password);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false);
                    },
                    child: const Text('Already Registered? Login here!')),
              ),
            ],
          ),
        ),
      );
    }
  }

  
  // @override
  // Widget build(BuildContext context) {
  //   double screenWidth = MediaQuery.of(context).size.width;

  //     return Scaffold(
  //       body: Container(
  //         decoration: const BoxDecoration(
  //           // Add a background image to the container
  //           image: DecorationImage(
  //             image: AssetImage('lib/assets/images/design.png'),
  //             fit: BoxFit.fill,
  //           ),
  //         ),
  //         child: Column(
  //           children: [
  //             const SizedBox(height: 50),
  //             Container(
  //               margin: const EdgeInsets.only(left: 35, top: 20),
  //               child: Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Image.asset(
  //                   'lib/assets/images/logo.png',
  //                   width: 140,
  //                   height: 140,
  //                   fit: BoxFit.contain,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 50),
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[200],
  //                 borderRadius: BorderRadius.circular(5.0),
  //               ),
  //               margin:
  //                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: TextField(
  //                 controller: _name,
  //                 autocorrect: false,
  //                 keyboardType:
  //                     TextInputType.name, // Set input type to phone number
  //                 decoration: const InputDecoration(
  //                   hintText: 'Enter your name',
  //                   border: InputBorder.none,
  //                   suffixIcon: Icon(Icons.account_circle),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[200],
  //                 borderRadius: BorderRadius.circular(5.0),
  //               ),
  //               margin:
  //                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: TextField(
  //                 controller: _phoneNumber,
  //                 autocorrect: false,
  //                 keyboardType:
  //                     TextInputType.phone, // Set input type to phone number
  //                 decoration: const InputDecoration(
  //                   hintText: 'Enter your phone number',
  //                   border: InputBorder.none,
  //                   suffixIcon: Icon(Icons.phone),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[200],
  //                 borderRadius: BorderRadius.circular(5.0),
  //               ),
  //               margin:
  //                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: TextField(
  //                 controller: _password,
  //                 obscureText: _obscureText,
  //                 enableSuggestions: false,
  //                 autocorrect: false,
  //                 decoration: InputDecoration(
  //                   hintText: 'Enter your password',
  //                   border: InputBorder.none,
  //                   suffixIcon: GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         _obscureText = !_obscureText;
  //                       });
  //                     },
  //                     child: Icon(
  //                       _obscureText ? Icons.visibility : Icons.visibility_off,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.only(top: 0), // Add margin as needed
  //               child: AnimatedOpacity(
  //                 opacity: _isLoading ? 1.0 : 0.0,
  //                 duration: const Duration(milliseconds: 500),
  //                 child: Container(
  //                   margin: const EdgeInsets.only(
  //                       top: 16, bottom: 16), // Add margin to control spacing
  //                   child: const CircularProgressIndicator(),
  //                 ),
  //               ),
  //             ),
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: Container(
  //                 width: screenWidth /
  //                     2, // Set the width to half of the screen width
  //                 margin: const EdgeInsets.only(top: 0, right: 30),
  //                 decoration: BoxDecoration(
  //                   color: const Color.fromARGB(255, 64, 173, 162),
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: TextButton(
  //                   onPressed: () async {
  //                     String phone = _phoneNumber.text;
  //                     String password = _password.text;
  //                     String name = _name.text;

  //                     // Call the registerUser function with phone and password
  //                     registerUser(name, phone, password);
  //                   },
  //                   child: const Text(
  //                     'Register',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pushNamedAndRemoveUntil(
  //                         loginRoute, (route) => false);
  //                   },
  //                   child: const Text('Already Registered? Login here!')),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  