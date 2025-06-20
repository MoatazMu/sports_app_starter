import 'package:flutter/material.dart';

class BookingStartScreen extends StatelessWidget {
  const BookingStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Booking'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'What would you like to do?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _actionTile(
              context: context,
              icon: Icons.calendar_today,
              title: 'Book a Venue',
              subtitle: 'Find and reserve courts or fields',
              routeName: '/book-venue',
            ),
            const SizedBox(height: 16),
            _actionTile(
              context: context,
              icon: Icons.groups,
              title: 'Host a Match',
              subtitle: 'Organize a public or private game',
              routeName: '/host',
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: [
                _quickChip('Repeat Last Match', Icons.refresh),
                _quickChip('Find Players', Icons.person_search),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _actionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String routeName,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.deepPurple.shade100),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurple),
          ],
        ),
      ),
    );
  }

  Widget _quickChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.deepPurple),
      backgroundColor: Colors.grey.shade100,
      label: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}