

import 'package:flutter/material.dart';

class VerifyNewMobileOTPScreen extends StatefulWidget {
  final String mobileNumber;

  const VerifyNewMobileOTPScreen({super.key, required this.mobileNumber});

  @override
  State<VerifyNewMobileOTPScreen> createState() => _VerifyNewMobileOTPScreenState();
}

class _VerifyNewMobileOTPScreenState extends State<VerifyNewMobileOTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  void _verifyOTP() {
    String otp = _otpController.text;
    if (otp.length == 4) {
      // TODO: Add OTP verification logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify New Number'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the 4-digit code sent to ${widget.mobileNumber}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: 'OTP Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}