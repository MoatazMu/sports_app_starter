import 'package:flutter/material.dart';

class InviteParticipantsScreen extends StatefulWidget {
  const InviteParticipantsScreen({super.key});

  @override
  State<InviteParticipantsScreen> createState() => _InviteParticipantsScreenState();
}

class _InviteParticipantsScreenState extends State<InviteParticipantsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> followingUsers = [
    {'id': 1, 'name': 'Ahmed', 'avatar': 'https://api.a0.dev/assets/image?text=A&aspect=1:1'},
    {'id': 2, 'name': 'Sara', 'avatar': 'https://api.a0.dev/assets/image?text=S&aspect=1:1'},
  ];

  final List<Map<String, dynamic>> allUsers = [
    {'id': 3, 'name': 'Kareem', 'avatar': 'https://api.a0.dev/assets/image?text=K&aspect=1:1'},
    {'id': 4, 'name': 'Youssef', 'avatar': 'https://api.a0.dev/assets/image?text=Y&aspect=1:1'},
    {'id': 5, 'name': 'Amal', 'avatar': 'https://api.a0.dev/assets/image?text=Am&aspect=1:1'},
  ];

  final Set<int> selectedIds = {};

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void _toggleSelection(int userId) {
    setState(() {
      if (selectedIds.contains(userId)) {
        selectedIds.remove(userId);
      } else {
        selectedIds.add(userId);
      }
    });
  }

  List<Map<String, dynamic>> getCurrentTabUsers() {
    return _tabController.index == 0 ? followingUsers : allUsers;
  }

  void _confirmSelection() {
    final selected = [...followingUsers, ...allUsers].where((u) => selectedIds.contains(u['id'])).toList();
    Navigator.pop(context, selected);
  }

  Widget _buildUserTile(Map<String, dynamic> user) {
    final isSelected = selectedIds.contains(user['id']);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user['avatar'])),
      title: Text(user['name']),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (_) => _toggleSelection(user['id']),
      ),
      onTap: () => _toggleSelection(user['id']),
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = getCurrentTabUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Participants'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepPurple,
          tabs: const [
            Tab(text: 'Following'),
            Tab(text: 'All'),
          ],
          onTap: (_) => setState(() {}),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: users.map(_buildUserTile).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _confirmSelection,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Invite Selected', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
