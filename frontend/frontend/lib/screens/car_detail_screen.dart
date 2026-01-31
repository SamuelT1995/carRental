import 'package:flutter/material.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Safely get arguments
    final car =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Handle case where car data might be missing
    if (car == null) {
      return const Scaffold(body: Center(child: Text("Car details not found")));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // IMAGE HEADER SECTION
          Container(
            height: 380,
            width: double.infinity,
            color: const Color(0xFFF5F5F7),
            child: Center(
              child: Hero(
                tag:
                    'car-${car['id']}', // Optional: matches animation from home
                child: Image.asset(
                  car['image_url'] ?? 'assets/placeholder.png',
                  width: 300,
                  fit: BoxFit.contain,
                  // THIS FIXES THE CRASH:
                  errorBuilder: (context, error, stackTrace) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_car,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Image not found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          // DETAILS SECTION
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (car['brand'] ?? 'Luxury').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    car['model'] ?? 'Car Model',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'DESCRIPTION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    car['description'] ??
                        'Experience peak automotive engineering with the ${car['model']}. '
                            'Designed for those who demand excellence in every mile.',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  const Spacer(),

                  // PRICE & ACTION ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Price / Day",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "\$${car['price_per_day']}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/payment',
                              arguments: car,
                            ),
                            child: const Text(
                              'PROCEED TO PAYMENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
