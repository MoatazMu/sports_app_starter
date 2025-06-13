import 'package:flutter/material.dart';

class DateTimeRepeatScreen extends StatefulWidget {
  const DateTimeRepeatScreen({super.key});

  @override
  State<DateTimeRepeatScreen> createState() => _DateTimeRepeatScreenState();
}

class _DateTimeRepeatScreenState extends State<DateTimeRepeatScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String repeat = 'Never';
  String endRepeat = 'Until Cancel';
  DateTime? repeatEndDate;

  final List<String> repeatOptions = ['Never', 'Weekly', 'Biweekly', 'Monthly'];
  final List<String> endRepeatOptions = ['Until Cancel', 'On Date'];

  late Map<String, dynamic> selectedVenue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedVenue = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  }

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
        initialTime: const TimeOfDay(hour: 18, minute: 0),
      );

      if (time != null) {
        setState(() {
          selectedDate = date;
          selectedTime = time;
        });
      }
    }
  }

  Future<void> _pickEndRepeatDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: selectedDate?.add(const Duration(days: 1)) ?? DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => repeatEndDate = date);
    }
  }

  String get dateTimeText {
    if (selectedDate == null || selectedTime == null) return 'Select Start Time';
    final date = '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
    final time = selectedTime!.format(context);
    return '$date at $time';
  }

  String get repeatEndText {
    if (endRepeat == 'Until Cancel') return 'Until Cancel';
    if (repeatEndDate == null) return 'Select End Date';
    return '${repeatEndDate!.day}/${repeatEndDate!.month}/${repeatEndDate!.year}';
  }

  void _submit() {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }

    if (endRepeat == 'On Date' && repeatEndDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select end date for repetition')),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/booking-summary',
      arguments: {
        'venue': selectedVenue,
        'startDate': selectedDate,
        'startTime': selectedTime,
        'repeat': repeat,
        'endRepeat': endRepeat,
        'repeatEndDate': repeatEndDate,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date, Time & Repeat'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(dateTimeText),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDateTime,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: repeat,
              items: repeatOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (val) => setState(() => repeat = val!),
              decoration: const InputDecoration(labelText: 'Repeat'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: endRepeat,
              items: endRepeatOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (val) => setState(() => endRepeat = val!),
              decoration: const InputDecoration(labelText: 'End Repeat'),
            ),
            if (endRepeat == 'On Date')
              ListTile(
                title: const Text('Repeat Until'),
                subtitle: Text(repeatEndText),
                trailing: const Icon(Icons.date_range),
                onTap: _pickEndRepeatDate,
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}