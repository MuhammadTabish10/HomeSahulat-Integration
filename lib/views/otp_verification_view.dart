import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/constants/routes.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
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
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                counterText: '',
                hintText: 'OTP',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Add backend logic for OTP verification
                Navigator.of(context).pushReplacementNamed(homeRoute);
              },
              child: const Text('Verify OTP'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // TODO: Resend OTP functionality
              },
              child: const Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}