import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart'; // Import the new screen

// The HomeScreen now simply displays the new tabbed DashboardScreen.
// All UI and logic like logout is contained within the DashboardScreen itself.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreen();
  }
}
