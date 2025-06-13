import 'package:flutter/material.dart';

class EmptyStatesScreen extends StatelessWidget {
  final String type; // e.g. 'bookings', 'matches', etc.

  const EmptyStatesScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    String message;
    String buttonText;

    switch (type) {
      case 'bookings':
        message = "You haven't booked any matches yet.";
        buttonText = "Book Now";
        break;
      case 'matches':
        message = "No matches found nearby.";
        buttonText = "Explore Matches";
        break;
      default:
        message = "Nothing to show here.";
        buttonText = "Go Home";
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sentiment_dissatisfied, size: 100, color: Colors.grey),
              const SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (type == 'bookings') {
                    Navigator.pushNamed(context, '/booking');
                  } else if (type == 'matches') {
                    Navigator.pushNamed(context, '/explore');
                  } else {
                    Navigator.pushNamed(context, '/');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}