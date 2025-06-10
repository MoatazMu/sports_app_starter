import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? startDate;
  TimeOfDay? startTime;
  int durationHours = 1;
  String repeatOption = 'Never';
  String endRepeatOption = 'Until Cancelled';
  DateTime? endRepeatDate;
  String whoCanJoin = 'Just Me';
  List<String> selectedUsers = [];

  final List<String> repeatOptions = [
    'Never',
    'Every Week',
    'Every 2 Weeks',
    'Every Month'
  ];

  final List<String> endRepeatOptions = [
    'Until Cancelled',
    'On a Date'
  ];

  final List<String> whoOptions = [
    'Just Me',
    'Anyone',
    'Only Invited'
  ];

  final List<String> allUsers = [
    'Ali', 'Sara', 'John', 'Lina', 'Ahmed', 'Emily'
  ]; // Mock data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Game')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Start Date & Time', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickDate,
                    child: Text(startDate == null
                        ? 'Select Date'
                        : DateFormat('yMMMd').format(startDate!)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickTime,
                    child: Text(startTime == null
                        ? 'Select Time'
                        : startTime!.format(context)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text('Duration (Hours)', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<int>(
              value: durationHours,
              items: List.generate(6, (i) => i + 1)
                  .map((h) => DropdownMenuItem(value: h, child: Text('$h hr')))
                  .toList(),
              onChanged: (val) => setState(() => durationHours = val!),
            ),
            const SizedBox(height: 16),
            const Text('Repeat', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: repeatOption,
              items: repeatOptions
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) => setState(() => repeatOption = val!),
            ),
            const SizedBox(height: 16),
            const Text('End Repeat', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: endRepeatOption,
              items: endRepeatOptions
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) => setState(() => endRepeatOption = val!),
            ),
            if (endRepeatOption == 'On a Date')
              ElevatedButton(
                onPressed: _pickEndRepeatDate,
                child: Text(endRepeatDate == null
                    ? 'Select Date'
                    : DateFormat('yMMMd').format(endRepeatDate!)),
              ),
            const SizedBox(height: 16),
            const Text('Who Can Join?', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: whoCanJoin,
              items: whoOptions
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) => setState(() => whoCanJoin = val!),
            ),
            if (whoCanJoin == 'Only Invited')
              Wrap(
                spacing: 8,
                children: allUsers.map((user) {
                  final isSelected = selectedUsers.contains(user);
                  return FilterChip(
                    label: Text(user),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedUsers.add(user);
                        } else {
                          selectedUsers.remove(user);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Confirm Booking'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => startDate = picked);
    }
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => startTime = picked);
    }
  }

  void _pickEndRepeatDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => endRepeatDate = picked);
    }
  }

  void _submit() {
    if (startDate == null || startTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }
    // Handle booking logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking Confirmed!')),
    );
  }
}