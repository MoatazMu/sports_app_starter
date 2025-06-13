import 'package:flutter/material.dart';

class MyRewardsScreen extends StatelessWidget {
  final int totalPoints = 120;
  final List<Map<String, dynamic>> rewards = [
    {'title': '10 AED Voucher', 'points': 50, 'expired': false},
    {'title': 'Free Booking Hour', 'points': 100, 'expired': false},
    {'title': '20 AED Voucher', 'points': 150, 'expired': true},
  ];

  MyRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Points: $totalPoints',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: totalPoints / 150,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              minHeight: 8,
            ),
            const SizedBox(height: 24),
            const Text('Available Rewards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: rewards.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  final isExpired = reward['expired'] == true;
                  return Opacity(
                    opacity: isExpired ? 0.5 : 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reward['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('${reward['points']} pts',
                                  style: const TextStyle(color: Colors.deepPurple)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: isExpired ? null : () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: const Text('Redeem'),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}