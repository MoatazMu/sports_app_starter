import 'package:flutter/material.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final venue = args['venue'] as Map<String, dynamic>;
    final startDate = args['startDate'] as DateTime;
    final startTime = args['startTime'] as TimeOfDay;
    final repeat = args['repeat'] as String;
    final endRepeat = args['endRepeat'] as String;
    final repeatEndDate = args['repeatEndDate'] as DateTime?;

    final dateText = "${startDate.day}/${startDate.month}/${startDate.year}";
    final timeText = startTime.format(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text('You’re all set!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Your booking has been confirmed.',
                style: TextStyle(fontSize: 16, color: Colors.grey)),

            const SizedBox(height: 32),
            _infoRow('Venue', venue['name']),
            _infoRow('Sport', venue['sport']),
            _infoRow('Date', dateText),
            _infoRow('Time', timeText),
            _infoRow('Price', venue['price']),
            _infoRow('Repeat', repeat),
            if (repeat != 'Never') _infoRow('End Repeat', endRepeat == 'On Date'
              ? "${repeatEndDate!.day}/${repeatEndDate.month}/${repeatEndDate.year}"
              : 'Until Cancel'),

            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Future: implement share logic
              },
              child: const Text('Share Match Details'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}