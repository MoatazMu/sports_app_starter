import 'package:flutter/material.dart';

class HostMatchScreen extends StatefulWidget {
  const HostMatchScreen({super.key});

  @override
  State<HostMatchScreen> createState() => _HostMatchScreenState();
}

class _HostMatchScreenState extends State<HostMatchScreen> {
  final _formKey = GlobalKey<FormState>();
  String sport = 'Football';
  String title = '';
  String description = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String duration = '1 hour';
  String repeat = 'Never';
  String joinOption = 'Anyone';

  final List<String> sports = ['Football', 'Padel', 'Cricket'];
  final List<String> durations = ['1 hour', '2 hours', '3 hours'];
  final List<String> repeatOptions = ['Never', 'Weekly', 'Biweekly', 'Monthly'];
  final List<String> joinOptions = ['Just Me', 'Anyone', 'Only Invited'];

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 18, minute: 0),
      );
      if (time != null) {
        setState(() {
          selectedDate = date;
          selectedTime = time;
        });
      }
    }
  }

  String get dateTimeText {
    if (selectedDate == null || selectedTime == null) return 'Select Time';
    final date = '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
    final time = selectedTime!.format(context);
    return '$date at $time';
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      // Here you'd save match details or navigate
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Match Created'),
          content: const Text('Your match has been hosted successfully.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Host a Match'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Match Title'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onChanged: (value) => title = value,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: sport,
                items: sports.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (val) => setState(() => sport = val!),
                decoration: const InputDecoration(labelText: 'Sport'),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date & Time'),
                subtitle: Text(dateTimeText),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDateTime,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: duration,
                items: durations.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (val) => setState(() => duration = val!),
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: repeat,
                items: repeatOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                onChanged: (val) => setState(() => repeat = val!),
                decoration: const InputDecoration(labelText: 'Repeat'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: joinOption,
                items: joinOptions.map((j) => DropdownMenuItem(value: j, child: Text(j))).toList(),
                onChanged: (val) => setState(() => joinOption = val!),
                decoration: const InputDecoration(labelText: 'Who can join?'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description / Rules'),
                onChanged: (value) => description = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Host Match', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}