import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // NEW LOGOUT FUNCTION: Wipes the memory clean
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This deletes the userId so we can start fresh
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFF5F5F7),
                child: Icon(Icons.person, size: 40, color: Colors.black),
              ),
              const SizedBox(height: 24),
              const Text(
                'JAMESON REED',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'PREMIUM MEMBER',
                style: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 48),
              _profileLink('Account Settings'),
              _profileLink('Payment Methods'),
              _profileLink('Driving License'),
              _profileLink('Privacy Policy'),
              const SizedBox(height: 48),

              // UPDATED LOGOUT BUTTON
              TextButton(
                onPressed: () => _logout(context),
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
    );
  }

  Widget _profileLink(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF5F5F7))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Color(0xFF8E8E93),
          ),
        ],
      ),
    );
  }
}
