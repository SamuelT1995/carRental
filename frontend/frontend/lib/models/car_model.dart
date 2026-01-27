class Car {
  final String id;
  final String brand;
  final String model;
  final double pricePerDay;
  final String imageUrl;
  final bool isAvailable;
  // Extra fields for the "Cool" factor
  final String description;
  final String speed;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.pricePerDay,
    required this.imageUrl,
    required this.isAvailable,
    this.description =
        "Experience the ultimate comfort and performance with this premium vehicle. Perfect for business or leisure.",
    this.speed = "240 km/h",
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150',
      isAvailable: json['isAvailable'] ?? true,
    );
  }
}
