import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _phoneNumber;
  late final TextEditingController _password;
  bool _obscureText = true;

  @override
  void initState() {
    _phoneNumber = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset(
            'lib/assets/images/logo.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 50),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
          Row(
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 64, 173, 162),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () async {
                final phone = _phoneNumber.text;
                final password = _password.text;

                Navigator.of(context)
                    .pushNamedAndRemoveUntil(homeRoute, (route) => false);

                // try {
                //   await AuthService.firebase().logIn(
                //     email: email,
                //     password: password,
                //   );
                //   final user = AuthService.firebase().currentUser;
                //   if (user?.isEmailVerified ?? false) {
                //     // user's email is verified
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //   homeRoute,
                //   (route) => false,
                //     );
                //   } else {
                //     // user's email is NOT verified
                //     Navigator.of(context).pushNamedAndRemoveUntil(
                //       emailVerifyRoute,
                //       (route) => false,
                //     );
                //   }
                // } on UserNotFoundAuthException {
                //   await showErrorDialog(
                //     context,
                //     'User not found',
                //   );
                // } on WrongPasswordAuthException {
                //   await showErrorDialog(
                //     context,
                //     'Wrong credentials',
                //   );
                // } on GenericAuthException {
                //   await showErrorDialog(
                //     context,
                //     'Authentication error',
                //   );
                // }
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
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Not Registered yet? Register here!'))
        ],
      ),
    ));
  }
}
