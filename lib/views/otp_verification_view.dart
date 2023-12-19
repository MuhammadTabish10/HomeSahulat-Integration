import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/constants/routes.dart';
import 'package:http/http.dart' as http;

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late final TextEditingController _otpController;

  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<bool> _verifyOtp(String id, String otp) async {
    try {
      final response =
          await http.get(Uri.parse(getOtpVerificationUrl(id, otp)));

      if (response.statusCode == 200) {
        return response.body.toLowerCase() == 'true';
      } else {
        // Handle the API error according to your requirements
        throw Exception(
            'Failed to verify OTP. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      debugPrint('Error during OTP verification: $error');
      throw Exception('Failed to verify OTP. Error: $error');
    }
  }

  Future<bool> _resendOtp(String id) async {
    try {
      final response = await http.post(Uri.parse(resendOtpUrl(id)));
      debugPrint('Resend OTP Response Code: ${response.statusCode}');
      debugPrint('Resend OTP Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response.body.toLowerCase() == 'true';
      } else {
        throw Exception(
            'Failed to resend OTP. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to resend OTP. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        // Adding a back button to the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          // Add a background image to the container
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design3.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the OTP sent to your mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  counterText: '',
                  hintText: 'OTP',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String otp = _otpController.text;
                    bool isOtpVerified = await _verifyOtp(userId, otp);

                    if (isOtpVerified) {
                      // OTP verification successful, navigate to the next screen
                      Navigator.of(context).pushReplacementNamed(loginRoute);
                    } else {
                      // OTP verification failed, show an error message
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid OTP. Please try again.'),
                      ));
                    }
                  } catch (error) {
                    // Handle API call errors here
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Failed to verify OTP. Please try again later.'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 64, 173, 162),
                ),
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  await _resendOtp(userId);
                },
                child: const Text('Resend OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
