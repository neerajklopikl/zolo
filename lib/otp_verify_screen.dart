import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// --- Screen 2: Verify OTP ---

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _phoneNumber;

  // --- REPLACE WITH YOUR NODE.JS BACKEND URL ---
  final String _apiUrl = "http://10.0.2.2:3000/api/verify-otp";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _phoneNumber = args;
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.isEmpty || _otpController.text.length < 6) {
      _showError("Please enter a valid 6-digit OTP.");
      return;
    }

    if (_phoneNumber == null) {
      _showError("An error occurred. Please try again.");
      Navigator.pop(context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phoneNumber': _phoneNumber,
          'otp': _otpController.text,
        }),
      );

      if (response.statusCode == 200) {
        // --- SAVE LOGIN STATE ---
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          );
        }
      } else {
        final body = json.decode(response.body);
        _showError(body['message'] ?? "Invalid OTP.");
      }
    } catch (e) {
      _showError("An error occurred. Please check your connection.");
      print("Error verifying OTP: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Enter OTP",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "An OTP has been sent to $_phoneNumber",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 4),
              textAlign: TextAlign.center,
              maxLength: 6, // Assuming a 6-digit OTP
              decoration: const InputDecoration(
                hintText: "123456",
                counterText: "",
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _verifyOtp,
                    child: const Text('Verify OTP', style: TextStyle(fontSize: 16)),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Didn't receive code? Resend."),
            )
          ],
        ),
      ),
    );
  }
}
