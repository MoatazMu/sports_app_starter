import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      'title': 'Match Reminder',
      'subtitle': 'Your football game at Mirdif Park is today at 6:00 PM.'
    },
    {
      'title': 'Payment Successful',
      'subtitle': 'You’ve successfully booked Smash Padel Club.'
    },
    {
      'title': 'New Reward Unlocked!',
      'subtitle': 'You earned a 50 AED voucher after 10 matches!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications, color: Colors.deepPurple),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['subtitle']!),
          );
        },
      ),
    );
  }
}