// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/animations/shake_transition.dart';
import 'package:homesahulat_fyp/config/token_provider.dart';
import 'package:http/http.dart' as http;
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/widget/custom_toast.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late final TextEditingController _phoneNumber;
  late final TextEditingController _password;
  late bool _isLoading;
  bool _obscureText = true;

  late AnimationController _slideController;

  @override
  void initState() {
    _phoneNumber = TextEditingController();
    _password = TextEditingController();
    _isLoading = false;

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _password.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> login(String phone, String password) async {
    setState(() {
      _isLoading = true; // Set loading to true when login starts
    });

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful, extract user token from the response
        final Map<String, dynamic> responseData = json.decode(response.body);
        String token = responseData['jwt'].toString();

        // Use the TokenProvider to store the token
        Provider.of<TokenProvider>(context, listen: false).setToken(token);

        Navigator.of(context).pushNamedAndRemoveUntil(
          homeRoute,
          (route) => false,
          arguments: {'token': token},
        );

        print('Login successful');
      } else {
        // Login failed, handle the error
        final Map<String, dynamic> errorData = json.decode(response.body);

        if (errorData.containsKey('phone')) {
          // If the error is related to the phone number, display the phone number error
          final String phoneError = errorData['phone'].toString();
          CustomToast.showAlert(context, phoneError);
        } else if (errorData.containsKey('password')) {
          // If the error is related to the password, display the password error
          final String passwordError = errorData['password'].toString();
          CustomToast.showAlert(context, passwordError);
        } else {
          // Display a generic error message for other errors
          final String errorMessage = errorData['error'].toString();
          CustomToast.showAlert(context, errorMessage);
        }

        print('Login failed: ${response.statusCode}');
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
                child: ShakeTransition(
                  animation: _slideController,
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ShakeTransition(
              animation: _slideController,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _phoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
            ),
            ShakeTransition(
              animation: _slideController,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200]?.withOpacity(0.8),
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
            ),
            ShakeTransition(
              animation: _slideController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password functionality
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
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
              child: ShakeTransition(
                animation: _slideController,
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
                      final phone = _phoneNumber.text;
                      final password = _password.text;

                      await login(phone, password);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: const Text('Not Registered yet? Register here!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
