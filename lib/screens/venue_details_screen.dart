import 'package:flutter/material.dart';

class VenueDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> venue;

  const VenueDetailsScreen({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(venue['name']),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Image.network(
              'https://api.a0.dev/assets/image?text=${venue['name']}&aspect=16:9',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Venue Name
                  Text(
                    venue['name'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // Sport and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        venue['sport'],
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${venue['rating']}'),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Price
                  Text(
                    venue['price'],
                    style: const TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),

                  // Map Placeholder
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Text('📍 Venue Map')),
                  ),

                  const SizedBox(height: 16),

                  // Facilities
                  const Text(
                    'Facilities',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: const [
                      Chip(label: Text('Indoor')),
                      Chip(label: Text('Parking')),
                      Chip(label: Text('Changing Room')),
                      Chip(label: Text('Lighting')),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Book Now
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/date-time',
                          arguments: {'venue': venue},
                        );
                        if (result != null) {
                          Navigator.pushNamed(context, '/invite');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}