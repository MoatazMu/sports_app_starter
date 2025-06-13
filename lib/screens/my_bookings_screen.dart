import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  final List<Map<String, String>> bookings = const [
    {
      'sport': 'Football',
      'date': 'June 15, 2025',
      'time': '6:00 PM',
      'location': 'JVC Stadium',
      'status': 'Upcoming',
    },
    {
      'sport': 'Padel',
      'date': 'June 10, 2025',
      'time': '8:00 PM',
      'location': 'Al Quoz Courts',
      'status': 'Past',
    },
    {
      'sport': 'Cricket',
      'date': 'May 30, 2025',
      'time': '4:00 PM',
      'location': 'ICC Academy',
      'status': 'Cancelled',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
          bottom: const TabBar(
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepPurple,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _bookingList('Upcoming'),
            _bookingList('Past'),
            _bookingList('Cancelled'),
          ],
        ),
      ),
    );
  }

  Widget _bookingList(String status) {
    final filtered = bookings.where((b) => b['status'] == status).toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('No bookings found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final booking = filtered[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Chip(
                    label: Text(booking['sport']!),
                    backgroundColor: Colors.deepPurple.shade50,
                  ),
                  const Spacer(),
                  Text(booking['date']!, style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                booking['location']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text('${booking['time']}'),
              const SizedBox(height: 8),
              Text('Status: ${booking['status']}', style: const TextStyle(color: Colors.deepPurple)),
            ],
          ),
        );
      },
    );
  }
}