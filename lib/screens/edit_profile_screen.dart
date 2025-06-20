import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _gender;

  bool _isSaving = false;

  void _submitProfile() {
    if (_formKey.currentState!.validate() && _gender != null) {
      setState(() => _isSaving = true);

      // Simulate saving process (e.g., Firestore write)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isSaving = false);

        // For now just show a confirmation
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Profile Saved"),
            content: const Text("Your profile has been updated."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter your age';
                  final age = int.tryParse(value);
                  if (age == null || age < 5 || age > 100) return 'Enter a valid age';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                value: _gender,
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? 'Select a gender' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: '+971501234567'),
                      decoration: const InputDecoration(labelText: 'Mobile Number'),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/change_mobile');
                    },
                    child: const Text('Change'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _submitProfile,
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Save Profile"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}