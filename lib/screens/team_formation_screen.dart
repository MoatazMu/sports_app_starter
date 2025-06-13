import 'package:flutter/material.dart';

class TeamFormationScreen extends StatefulWidget {
  final List<String> players;

  const TeamFormationScreen({super.key, required this.players});

  @override
  State<TeamFormationScreen> createState() => _TeamFormationScreenState();
}

class _TeamFormationScreenState extends State<TeamFormationScreen> {
  late List<String> teamA;
  late List<String> teamB;

  @override
  void initState() {
    super.initState();
    _autoDistribute();
  }

  void _autoDistribute() {
    teamA = [];
    teamB = [];
    for (int i = 0; i < widget.players.length; i++) {
      if (i % 2 == 0) {
        teamA.add(widget.players[i]);
      } else {
        teamB.add(widget.players[i]);
      }
    }
  }

  void _swapPlayers(int fromTeam, int fromIndex, int toIndex) {
    setState(() {
      final player = fromTeam == 0 ? teamA.removeAt(fromIndex) : teamB.removeAt(fromIndex);
      if (fromTeam == 0) {
        teamB.insert(toIndex, player);
      } else {
        teamA.insert(toIndex, player);
      }
    });
  }

  Widget _buildTeamColumn(String title, List<String> team, int teamIndex) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...team.asMap().entries.map((entry) {
            final i = entry.key;
            final name = entry.value;
            return Card(
              child: ListTile(
                title: Text(name),
                trailing: IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: () {
                    _swapPlayers(teamIndex, i, 0);
                  },
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Formation'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              setState(() {
                _autoDistribute();
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildTeamColumn('Team A', teamA, 0),
            const SizedBox(width: 16),
            _buildTeamColumn('Team B', teamB, 1),
          ],
        ),
      ),
    );
  }
}