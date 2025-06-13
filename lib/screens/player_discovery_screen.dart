import 'package:flutter/material.dart';

class PlayerDiscoveryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> players = [
    {'name': 'Moataz', 'skill': 'Intermediate', 'sport': 'Football'},
    {'name': 'Omar', 'skill': 'Beginner', 'sport': 'Padel'},
    {'name': 'Sara', 'skill': 'Advanced', 'sport': 'Cricket'},
    {'name': 'Youssef', 'skill': 'Intermediate', 'sport': 'Football'},
    {'name': 'Amal', 'skill': 'Beginner', 'sport': 'Padel'},
    {'name': 'Ahmed', 'skill': 'Advanced', 'sport': 'Cricket'},
  ];

  PlayerDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Players'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return _buildPlayerCard(player);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: 'Football',
              decoration: const InputDecoration(
                labelText: 'Sport',
                border: OutlineInputBorder(),
              ),
              items: ['Football', 'Padel', 'Cricket']
                  .map((sport) => DropdownMenuItem(value: sport, child: Text(sport)))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: 'All',
              decoration: const InputDecoration(
                labelText: 'Skill',
                border: OutlineInputBorder(),
              ),
              items: ['All', 'Beginner', 'Intermediate', 'Advanced']
                  .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(Map<String, dynamic> player) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://api.a0.dev/assets/image?text=${player['name']}&aspect=1:1',
            ),
            radius: 28,
          ),
          const SizedBox(height: 8),
          Text(player['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(player['sport'], style: const TextStyle(color: Colors.grey)),
          Text(player['skill'], style: const TextStyle(fontSize: 12, color: Colors.deepPurple)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            child: const Text('Invite'),
          ),
        ],
      ),
    );
  }
}