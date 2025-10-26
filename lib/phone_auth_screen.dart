import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// --- Screen 1: Enter Phone Number ---

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  // --- REPLACE WITH YOUR NODE.JS BACKEND URL ---
  final String _apiUrl = "http://10.0.2.2:3000/api/send-otp";
  // Note: 10.0.2.2 is the address for localhost on the Android emulator.
  // Use your machine's IP address if testing on a physical device.

  Future<void> _sendOtp() async {
    if (_phoneController.text.isEmpty) {
      _showError("Please enter a phone number.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phoneNumber': _phoneController.text}),
      );

      if (response.statusCode == 200) {
        // Navigate to the OTP verification screen
        if (mounted) {
          Navigator.pushNamed(
            context,
            '/verify',
            arguments: _phoneController.text, // Pass phone number
          );
        }
      } else {
        // Handle server errors
        final body = json.decode(response.body);
        _showError(body['message'] ?? "Failed to send OTP.");
      }
    } catch (e) {
      // Handle network errors
      _showError("An error occurred. Please check your connection.");
      print("Error sending OTP: $e");
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
        title: const Text('Mobile Authentication'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Enter Your Mobile Number",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "We will send you a one-time password (OTP)",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "+1 123 456 7890",
                prefixIcon: Icon(Icons.phone_android, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _sendOtp,
                    child: const Text('Send OTP', style: TextStyle(fontSize: 16)),
                  ),
          ],
        ),
      ),
    );
  }
}
