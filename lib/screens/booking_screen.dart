import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Booking"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            _bookingOption(
              context,
              icon: Icons.calendar_today,
              title: "Book a Venue",
              description: "Reserve a venue for your private match.",
              routeName: '/book-venue', // Placeholder, to be created in next steps
            ),
            const SizedBox(height: 24),
            _bookingOption(
              context,
              icon: Icons.sports_soccer,
              title: "Host a Match",
              description: "Create a public or private match.",
              routeName: '/host-match', // Placeholder, to be created in next steps
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                // Optional: link to recent bookings or last match
              },
              child: const Text("Repeat Last Match"),
            )
          ],
        ),
      ),
    );
  }

  Widget _bookingOption(BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String routeName,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.deepPurple.shade100),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.deepPurple.shade50,
              child: Icon(icon, size: 28, color: Colors.deepPurple),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
