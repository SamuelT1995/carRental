import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CarListingsScreen extends StatelessWidget {
  const CarListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ALL VEHICLES',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService.fetchCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No cars available."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final car = snapshot.data![index];
              return _buildListingCard(context, car);
            },
          );
        },
      ),
    );
  }

  Widget _buildListingCard(BuildContext context, dynamic car) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: car),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Image.asset(
              car['image_url'] ?? 'assets/porsche_taycan.png',
              width: 100,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.directions_car, size: 50),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['brand']?.toUpperCase() ?? '',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  car['model']?.toUpperCase() ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$${car['price_per_day']}/DAY',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
