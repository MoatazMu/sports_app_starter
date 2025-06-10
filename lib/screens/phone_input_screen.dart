import 'package:flutter/material.dart';
import 'package:sports_app_starter/services/auth_service.dart';
import 'otp_verification_screen.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _error;

  void _sendOTP() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty || !phone.startsWith('+971') || phone.length < 10) {
      setState(() => _error = 'Enter a valid UAE phone number (e.g., +971XXXXXXXXX)');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    await _authService.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (credential) {
        // Optional: Auto-sign in for some Android devices
      },
      verificationFailed: (error) {
        setState(() {
          _isLoading = false;
          _error = error;
        });
      },
      codeSent: (verificationId) {
        setState(() => _isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPVerificationScreen(
              phoneNumber: phone,
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (_, __) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify your phone")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text("Enter your mobile number", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixText: '+971 ',
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendOTP,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Send Code"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}