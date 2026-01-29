import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/car_listing_screen.dart';
import 'screens/car_detail_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/booking_success_screen.dart';
import 'screens/my_bookings_screen.dart';
import 'screens/profile_screen.dart';

void main() => runApp(const CarRentalApp());

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/listing': (context) => const CarListingScreen(),
        '/detail': (context) => const CarDetailScreen(),
        '/booking': (context) => const BookingScreen(),
        '/success': (context) => const BookingSuccessScreen(),
        '/my_bookings': (context) => const MyBookingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
