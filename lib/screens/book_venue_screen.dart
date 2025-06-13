import 'package:flutter/material.dart';

class BookVenueScreen extends StatelessWidget {
  const BookVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> venues = [
      {
        'name': 'Smash Padel Club',
        'location': 'Al Quoz',
        'sport': 'Padel',
        'rating': 4.8,
        'price': 'AED 280/hr',
        'image': 'https://api.a0.dev/assets/image?text=Smash+Padel&aspect=16:9',
      },
      {
        'name': 'Dubai Sports City',
        'location': 'Sports City',
        'sport': 'Football',
        'rating': 4.7,
        'price': 'AED 600/hr',
        'image': 'https://api.a0.dev/assets/image?text=Dubai+Sports+City&aspect=16:9',
      },
      {
        'name': 'ICC Academy',
        'location': 'Dubai Sports City',
        'sport': 'Cricket',
        'rating': 4.9,
        'price': 'AED 450/hr',
        'image': 'https://api.a0.dev/assets/image?text=ICC+Academy&aspect=16:9',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Venue"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          return GestureDetector(
            onTap: () {
              // Navigate to Date & Time selection, passing the selected venue
              Navigator.pushNamed(
                context,
                '/date-time-repeat',
                arguments: venue,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      venue['image'],
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${venue['location']} • ${venue['sport']}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              venue['price'],
                              style: const TextStyle(
                                  color: Colors.deepPurple, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.amber),
                                Text(
                                  '${venue['rating']}',
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}