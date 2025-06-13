import 'package:flutter/material.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  void _allowNotifications(BuildContext context) {
    // Simulate granting permission
    Navigator.pushReplacementNamed(context, '/walkthrough');
  }

  void _skipForNow(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/walkthrough');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_active, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 24),
            const Text(
              'Stay Updated!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Get real-time match invites, booking reminders, and rewards notifications.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _allowNotifications(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Enable Notifications'),
              ),
            ),
            TextButton(
              onPressed: () => _skipForNow(context),
              child: const Text('Maybe later', style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        ),
      ),
    );
  }
}