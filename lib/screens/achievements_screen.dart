import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> badges = [
    {'title': 'First Match', 'unlocked': true},
    {'title': '5 Matches Played', 'unlocked': true},
    {'title': '10 Matches Played', 'unlocked': false},
    {'title': 'First Booking', 'unlocked': true},
    {'title': 'Weekly Streak', 'unlocked': false},
    {'title': 'Invite a Friend', 'unlocked': false},
  ];

  AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: badges.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final badge = badges[index];
            final isUnlocked = badge['unlocked'] == true;

            return Container(
              decoration: BoxDecoration(
                color: isUnlocked ? Colors.deepPurple.shade50 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isUnlocked ? Colors.deepPurple : Colors.grey,
                  width: 2,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isUnlocked ? Icons.emoji_events : Icons.lock_outline,
                      size: 40,
                      color: isUnlocked ? Colors.deepPurple : Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      badge['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isUnlocked ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (!isUnlocked)
                      const Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Text('Locked',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}