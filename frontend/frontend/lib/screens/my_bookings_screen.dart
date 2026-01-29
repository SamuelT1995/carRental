import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // The back arrow is here for redundancy, but the Navbar is the primary way home
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        title: const Text(
          'MY RIDES',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        // Changed to ListView for easier scrolling
        padding: const EdgeInsets.all(24.0),
        children: [
          _bookingCard(
            context,
            'Tesla Model S',
            'Oct 24 - Oct 26',
            'ACTIVE',
            'assets/tesla_model_s.png',
          ),
          const SizedBox(height: 16),
          _bookingCard(
            context,
            'Porsche Taycan',
            'Oct 28 - Oct 30',
            'UPCOMING',
            'assets/porsche_taycan.png',
          ),
        ],
      ),
      // THIS IS THE KEY: Putting it here keeps it visible
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }

  Widget _bookingCard(
    BuildContext context,
    String car,
    String dates,
    String status,
    String imgPath,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                imgPath,
                width: 100,
                height: 60,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.directions_car),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      dates,
                      style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/success'),
                child: const Text(
                  'VIEW DETAILS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
