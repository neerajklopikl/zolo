import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';
import 'dashboard_card.dart'; // Import the card widget

class DashboardGrid extends StatelessWidget {
  final List<DashboardItem> items;
  final int crossAxisCount;
  final double childAspectRatio; // Allow customizing aspect ratio

  const DashboardGrid({
    super.key,
    required this.items,
    this.crossAxisCount = 4, // Default columns
    this.childAspectRatio = 1.0, // Default aspect ratio (adjust based on card height)
  });

  @override
  Widget build(BuildContext context) {
    // Calculate aspect ratio dynamically or use provided value
     final screenWidth = MediaQuery.of(context).size.width;
     // Adjust padding and spacing based on your design
     final totalSpacing = (crossAxisCount + 1) * 8.0;
     final availableWidth = screenWidth - 32.0 - totalSpacing; // 16 padding each side
     final itemWidth = availableWidth / crossAxisCount;
     const itemHeight = 100.0; // Assuming fixed height from DashboardItemCard
     final calculatedAspectRatio = itemWidth / itemHeight;


    return GridView.builder(
      shrinkWrap: true, // Important for nested scrolling
      physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        // Use calculated aspect ratio unless overridden
        childAspectRatio: childAspectRatio == 1.0 ? calculatedAspectRatio : childAspectRatio,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return DashboardItemCard(item: items[index]);
      },
    );
  }
}