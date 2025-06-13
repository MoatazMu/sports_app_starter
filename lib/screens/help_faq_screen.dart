import 'package:flutter/material.dart';

class HelpFAQScreen extends StatelessWidget {
  const HelpFAQScreen({super.key});

  final List<Map<String, String>> faqItems = const [
    {
      'question': 'How do I book a venue?',
      'answer': 'Go to Home > Book a Venue, then filter and select a time slot.'
    },
    {
      'question': 'Can I cancel a booking?',
      'answer': 'Yes, go to My Bookings and select the match to cancel (if allowed).'
    },
    {
      'question': 'How do I earn rewards?',
      'answer': 'Play matches! Points are awarded after each completed game.'
    },
    {
      'question': 'How do I invite friends?',
      'answer': 'When creating a match, use the Invite Participants step.'
    },
    {
      'question': 'Need more help?',
      'answer': 'Tap "Contact Support" below to send us a message.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQ'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqItems.length + 1,
        itemBuilder: (context, index) {
          if (index == faqItems.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.support_agent),
                  label: const Text('Contact Support'),
                  onPressed: () {
                    // Navigate to contact form or show dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Support feature coming soon!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            );
          }

          final item = faqItems[index];
          return ExpansionTile(
            title: Text(item['question']!, style: const TextStyle(fontWeight: FontWeight.w600)),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(item['answer']!, style: const TextStyle(color: Colors.black87)),
              )
            ],
          );
        },
      ),
    );
  }
}