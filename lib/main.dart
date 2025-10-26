import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'phone_auth_screen.dart';
import 'otp_verify_screen.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  final String initialRoute = isLoggedIn ? '/home' : '/';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zolo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Set the theme to light
        scaffoldBackgroundColor: Colors.grey[100], // Match the dashboard background
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1.0,
          iconTheme: IconThemeData(color: Colors.black54),
          titleTextStyle: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10.0),
             borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10.0),
             borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
          ),
        ),
        cardTheme: CardTheme(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        )
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const PhoneAuthScreen(),
        '/verify': (context) => const OtpVerifyScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
