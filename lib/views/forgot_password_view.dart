import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/constants/api_end_points.dart';
import 'package:homesahulat_fyp/views/login_view.dart';
import 'package:homesahulat_fyp/widget/custom_toast.dart';
import 'package:homesahulat_fyp/widget/loader.dart'; // Import the loader widget
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _codeController;
  late final TextEditingController _newPasswordController;
  late bool _isLoading;
  late bool _isCodeStep;
  bool _emailSentSuccessfully = false;
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _codeController = TextEditingController();
    _newPasswordController = TextEditingController();
    _isLoading = false;
    _isCodeStep = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _navigateToCodeStep() {
    setState(() {
      _isCodeStep = true;
    });
  }

  Future<void> sendCodeByEmail(String email) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(forgotPasswordUrl(email)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _emailSentSuccessfully = true;
        debugPrint('Email sent successfully');
      } else {
        _emailSentSuccessfully = false;
        CustomToast.showAlert(context, "Email not sent successfully..!");
      }
    } catch (error) {
      _emailSentSuccessfully = false;
      debugPrint('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyCodeAndNavigate(
      String email, String resetCode, String newPassword) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(resetPasswordUrl(email, resetCode, newPassword)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Password updated successfully');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password updated successfully'),
            duration: Duration(seconds: 3),
          ),
        );

        // Clear controllers
        _emailController.clear();
        _codeController.clear();
        _newPasswordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        CustomToast.showAlert(context, "Password update failed..!");
      }
    } catch (error) {
      debugPrint('Error: $error');
      if (error.toString().contains("Invalid or expired reset code")) {
        CustomToast.showAlert(context, "Invalid or expired reset code");
      } else {
        CustomToast.showAlert(context, "Password update failed..!");
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        leading: _isCodeStep
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isCodeStep = false;
                  });
                },
              )
            : null,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/design2.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (!_isCodeStep)
                Column(
                  children: [
                    const Text(
                      'Enter your email to receive a verification code:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _emailFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Email cannot be empty'
                                : null,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_emailFormKey.currentState?.validate() ??
                                  false) {
                                String email = _emailController.text;
                                await sendCodeByEmail(email);
                                if (_emailSentSuccessfully) {
                                  debugPrint('Sending email to: $email');
                                  _navigateToCodeStep();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 64, 173, 162),
                            ),
                            child: const Text(
                              'Send Verification Code',
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
                  ],
                ),
              if (_isCodeStep)
                Column(
                  children: [
                    const Text(
                      'Enter the code sent to your email and a new password to reset your password:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _codeFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _codeController,
                            decoration:
                                const InputDecoration(labelText: 'Code'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Code cannot be empty'
                                : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _newPasswordController,
                            decoration: const InputDecoration(
                                labelText: 'New Password'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'New Password cannot be empty'
                                : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        String email = _emailController.text;
                        String resetCode = _codeController.text;
                        String newPassword = _newPasswordController.text;
                        // Validate the code and new password before proceeding
                        if (_codeFormKey.currentState?.validate() ?? false) {
                          await _verifyCodeAndNavigate(
                              email, resetCode, newPassword);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 64, 173, 162),
                      ),
                      child: const Text(
                        'Verify Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Center(
                child: LoaderWidget(isLoading: _isLoading),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
