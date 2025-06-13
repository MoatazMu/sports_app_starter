import 'package:flutter/material.dart';
import 'match_details_screen.dart';
import 'venue_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedTab = 'Matches';

  final List<Map<String, dynamic>> matches = [
    {
      'sport': 'Football',
      'time': 'Today, 7:00 PM',
      'location': 'Dubai Marina',
      'slots': 4,
      'date': 'June 13',
      'playersJoined': 6,
      'spotsLeft': 4,
      'description': 'Friendly football game at Dubai Marina pitch.'
    },
    {
      'sport': 'Cricket',
      'time': 'Tomorrow, 5:30 PM',
      'location': 'JVC Ground',
      'slots': 2,
      'date': 'June 14',
      'playersJoined': 8,
      'spotsLeft': 2,
      'description': 'Evening cricket session, beginner friendly.'
    },
  ];

  final List<Map<String, dynamic>> venues = [
    {
      'name': 'Al Quoz Arena',
      'sport': 'Padel',
      'rating': 4.6,
      'available': '6–10 PM',
      'price': 'AED 180/hour'
    },
    {
      'name': 'Zabeel Park',
      'sport': 'Football',
      'rating': 4.8,
      'available': 'All Day',
      'price': 'Free Entry'
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
          _searchBar(),
          _tabSelector(),
          Expanded(child: selectedTab == 'Matches' ? _matchList() : _venueList()),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search sports, venues, or players',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _tabSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _tabButton('Matches'),
          const SizedBox(width: 12),
          _tabButton('Venues'),
        ],
      ),
    );
  }

  Widget _tabButton(String label) {
    final isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _matchList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.sports, color: Colors.deepPurple),
            title: Text('${match['sport']} — ${match['time']}'),
            subtitle: Text('${match['location']} • ${match['slots']} slots left'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MatchDetailsScreen(match: match)),
              );
            },
          ),
        );
      },
    );
  }

  Widget _venueList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: venues.length,
      itemBuilder: (context, index) {
        final venue = venues[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.location_on, color: Colors.deepPurple),
            title: Text('${venue['name']} — ${venue['sport']}'),
            subtitle: Text('Rating: ${venue['rating']} • Available: ${venue['available']}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VenueDetailsScreen(venue: venue)),
              );
            },
          ),
        );
      },
    );
  }
}