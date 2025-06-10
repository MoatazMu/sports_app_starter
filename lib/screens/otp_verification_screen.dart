import 'package:flutter/material.dart';
import 'package:sports_app_starter/services/auth_service.dart';
import 'profile_info_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _codeController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isVerifying = false;
  String? _error;

  void _verifyCode() async {
    final code = _codeController.text.trim();

    if (code.length != 6) {
      setState(() => _error = "Enter the 6-digit code sent to your phone.");
      return;
    }

    setState(() {
      _isVerifying = true;
      _error = null;
    });

    final error = await _authService.signInWithOTP(
      verificationId: widget.verificationId,
      smsCode: code,
    );

    if (error != null) {
      setState(() {
        _error = error;
        _isVerifying = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileInfoScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Verification Code")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text("Code sent to ${widget.phoneNumber}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: '6-digit Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isVerifying ? null : _verifyCode,
                child: _isVerifying
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Verify"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}