import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _loading = false;

  void _handlePayment(Map<String, dynamic> car) async {
    setState(() => _loading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      // UUID is a String, so we use getString
      final String? userId = prefs.getString('userId');

      if (userId == null) {
        throw Exception("User ID not found. Please log in again.");
      }

      final double price = double.parse(car['price_per_day'].toString());

      final success = await ApiService.createBooking({
        "user_id": userId,
        "car_id": car['id'],
        "start_date": DateTime.now().toIso8601String(),
        "end_date": DateTime.now()
            .add(const Duration(days: 2))
            .toIso8601String(),
        "total_price": price * 2,
      });

      if (success && mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/confirmation',
          (route) => false,
        );
      } else {
        throw Exception("Server rejected the booking.");
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final car =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final double price = double.parse(car['price_per_day'].toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'PAYMENT',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  car['model'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('\$${price.toStringAsFixed(2)} x 2 Days'),
              ],
            ),
            const Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '\$${(price * 2).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () => _handlePayment(car),
                      child: const Text(
                        'CONFIRM BOOKING',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
