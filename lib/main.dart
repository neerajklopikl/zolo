import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import the new screen files
import 'phone_auth_screen.dart';
import 'otp_verify_screen.dart';
import 'home_screen.dart';

void main() async {
  // Ensure Flutter is ready before we check for login status
  WidgetsFlutterBinding.ensureInitialized();

  // Check login status using shared preferences
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Choose the initial route based on the login status
  final String initialRoute = isLoggedIn ? '/home' : '/';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  // Update constructor to accept the initial route
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OTP Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Dark theme for a modern look
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
      // Use the dynamically set initial route
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const PhoneAuthScreen(),
        '/verify': (context) => const OtpVerifyScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false, // Hides the debug banner
    );
  }
}
