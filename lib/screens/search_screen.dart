import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedSport = 'All';
  String selectedSkill = 'Any';
  String selectedSort = 'Nearest';

  final List<String> sports = ['All', 'Football', 'Padel', 'Cricket'];
  final List<String> skills = ['Any', 'Beginner', 'Intermediate', 'Pro'];
  final List<String> sortOptions = ['Nearest', 'Cheapest', 'Earliest'];

  final List<Map<String, dynamic>> results = [
    {
      'type': 'match',
      'sport': 'Football',
      'location': 'Barsha Park',
      'time': 'Today, 6:30 PM',
      'slots': 4,
      'price': 'AED 20',
    },
    {
      'type': 'venue',
      'name': 'Padel Pro Club',
      'sport': 'Padel',
      'rating': 4.8,
      'price': 'AED 300/hr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for matches, venues, players...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          // Filters
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildDropdown('Sport', sports, selectedSport, (val) => setState(() => selectedSport = val)),
                const SizedBox(width: 8),
                _buildDropdown('Skill', skills, selectedSkill, (val) => setState(() => selectedSkill = val)),
                const SizedBox(width: 8),
                _buildDropdown('Sort by', sortOptions, selectedSort, (val) => setState(() => selectedSort = val)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Results
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(
                        item['sport'] == 'Football'
                            ? Icons.sports_soccer
                            : item['sport'] == 'Padel'
                                ? Icons.sports_tennis
                                : Icons.sports_cricket,
                        color: Colors.deepPurple,
                      ),
                      title: Text(item['type'] == 'match' ? '${item['sport']} Match' : item['name']),
                      subtitle: Text(item['type'] == 'match'
                          ? '${item['location']} • ${item['time']}'
                          : '${item['sport']} • ${item['price']}'),
                      trailing: Text(item['type'] == 'match' ? '${item['slots']} slots' : '${item['rating']} ⭐'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, String current, Function(String) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: current,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down),
        items: options.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}