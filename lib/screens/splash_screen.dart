import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });

    return Scaffold(
      body: Center(
        child: Text("QuickServe", style: TextStyle(fontSize: 28)),
      ),
    );
  }
}