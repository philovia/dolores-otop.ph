// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:otop_front/components/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate splash screen duration
    Future.delayed(const Duration(seconds: 10), () {
      // Navigate to AuthForm after splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthForm()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 244, 154, 89),
              const Color.fromARGB(255, 119, 188, 220)
            ], // Set gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center, // Center both images and text
            children: [
              // The first image (background image)
              Image.asset(
                'images/otop.png', // Replace with your image path
                width: 900,
                height: 400,
              ),
              // Centered otopph image
              Image.asset(
                'images/otopph.png',
                width: 150,
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
