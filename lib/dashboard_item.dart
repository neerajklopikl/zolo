import 'package:flutter/material.dart';

// Data model for a dashboard item
class DashboardItem {
  final IconData icon;
  final String label;
  final Color? color; // Optional: for specific icon background colors
  final VoidCallback? onTap; // Optional: action to perform on tap

  DashboardItem({
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  });
}
