import 'package:flutter/material.dart';
import 'venue_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = {
    'name': 'Ahmed',
    'avatar': 'https://api.a0.dev/assets/image?text=Ahmed&aspect=1:1',
  };

  final List<Map<String, dynamic>> upcomingGames = [
    {
      'id': 1,
      'sport': 'Football',
      'location': 'Mirdif Park',
      'time': 'Today, 6:00 PM',
      'spotsLeft': 3
    },
    {
      'id': 2,
      'sport': 'Padel',
      'location': 'Downtown Courts',
      'time': 'Tomorrow, 7:30 PM',
      'spotsLeft': 1
    },
  ];

  final List<Map<String, dynamic>> venues = [
    {
      'id': 1,
      'name': 'Dubai Sports City',
      'sport': 'Football',
      'rating': 4.7,
      'price': 'AED 600/hr'
    },
    {
      'id': 2,
      'name': 'Smash Padel Club',
      'sport': 'Padel',
      'rating': 4.9,
      'price': 'AED 280/hr'
    },
    {
      'id': 3,
      'name': 'ICC Academy',
      'sport': 'Cricket',
      'rating': 4.8,
      'price': 'AED 450/hr'
    },
  ];

  int _selectedIndex = 0;

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // You can add more navigation logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good morning,", style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(user['name']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user['avatar']!),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionButton(Icons.sports_soccer, 'Join a Game'),
                _actionButton(Icons.calendar_today, 'Book a Venue'),
                _actionButton(Icons.search, 'Explore'),
              ],
            ),
            const SizedBox(height: 20),

            // Upcoming Games
            _sectionHeader('Upcoming Games'),
            ...upcomingGames.map((game) => _gameCard(game)).toList(),

            const SizedBox(height: 20),

            // Popular Venues
            _sectionHeader('Popular Venues'),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: venues.map((venue) => _venueCard(context, venue)).toList(),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.deepPurple),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('See All', style: TextStyle(color: Colors.deepPurple)),
        ],
      ),
    );
  }

  Widget _gameCard(Map<String, dynamic> game) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                label: Text(game['sport'], style: const TextStyle(color: Colors.deepPurple)),
                backgroundColor: Colors.deepPurple.shade50,
              ),
              const SizedBox(height: 8),
              Text(game['location'], style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(game['time'], style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Text('${game['spotsLeft']} spots', style: const TextStyle(color: Colors.deepPurple)),
              const Icon(Icons.chevron_right, color: Colors.deepPurple)
            ],
          )
        ],
      ),
    );
  }

  Widget _venueCard(BuildContext context, Map<String, dynamic> venue) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VenueDetailsScreen(venue: venue),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://api.a0.dev/assets/image?text=${venue['name']}&aspect=16:9',
              width: 220,
              height: 120,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(venue['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(venue['sport'], style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          Text('${venue['rating']}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      )
                    ],
                  ),
                  Text(venue['price'], style: const TextStyle(color: Colors.deepPurple)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}