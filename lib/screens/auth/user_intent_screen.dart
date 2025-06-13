import 'package:flutter/material.dart';

class UserIntentScreen extends StatefulWidget {
  const UserIntentScreen({super.key});

  @override
  State<UserIntentScreen> createState() => _UserIntentScreenState();
}

class _UserIntentScreenState extends State<UserIntentScreen> {
  String? selectedIntent;

  final List<Map<String, String>> intents = [
    {
      'title': 'Find nearby players',
      'description': 'Join local matches based on your skill and location.',
    },
    {
      'title': 'Show me venues to book',
      'description': 'Explore and book verified football, padel, and cricket venues.',
    },
    {
      'title': 'I’m just discovering',
      'description': 'Browse around to explore matches and venues casually.',
    },
  ];

  void _submit() {
    if (selectedIntent != null) {
      Navigator.pushReplacementNamed(context, '/'); // Go to HomeScreen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an option')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What brings you here?"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ...intents.map((intent) {
              final isSelected = selectedIntent == intent['title'];
              return GestureDetector(
                onTap: () => setState(() => selectedIntent = intent['title']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.deepPurple.shade50 : Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        intent['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        intent['description']!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const Spacer(),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}