import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer to navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      // pushReplacementNamed ensures the user can't "go back" to the splash screen
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black, // High-end, premium feel
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using an Icon as a placeholder logo
            Icon(Icons.directions_car_filled, size: 80, color: Colors.white),
            SizedBox(height: 24),
            Text(
              'LUx',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 8, // Spaced out for that "designer" look
              ),
            ),
            SizedBox(height: 8),
            Text(
              'DRIVE MODERNE',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
