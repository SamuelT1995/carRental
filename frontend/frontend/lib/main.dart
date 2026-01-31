import 'package:flutter/material.dart';
import 'package:frontend/screens/my_bookings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/car_listings_screen.dart';
import 'screens/car_detail_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/confirmation_screen.dart';

void main() {
  runApp(const LuxeDriveApp());
}

class LuxeDriveApp extends StatelessWidget {
  const LuxeDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxe Drive',
      theme: ThemeData(primaryColor: Colors.black, fontFamily: 'Inter'),
      initialRoute: '/login', // Set to login as default

      routes: {
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/all_listings': (context) => const CarListingsScreen(),
        '/detail': (context) => const CarDetailScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/confirmation': (context) => const ConfirmationScreen(),
        '/my_bookings': (context) =>
            const MyBookingsScreen(), // ADD THIS FOR NAV
      },
    );
  }
}
