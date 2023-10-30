import 'package:flutter/material.dart';
import 'package:homesahulat_fyp/utilities/themes.dart';
import 'package:homesahulat_fyp/views/login_view.dart';
import 'package:homesahulat_fyp/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
      routes: routes,
    );
  }
}
