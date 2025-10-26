import 'package:flutter/material.dart';
import '../models/dashboard_item.dart'; // Import the model

class DashboardItemCard extends StatelessWidget {
  final DashboardItem item;
  final bool isSmall; // To adjust size for Quick Links row if needed

  const DashboardItemCard({
    super.key,
    required this.item,
    this.isSmall = false,
  });

  // Helper to get default background colors (customize as needed)
  Color _getIconBackgroundColor(IconData icon) {
    // Simple example - assign colors based on icon for variety
    int hashCode = icon.hashCode;
    List<Color> colors = [
      Colors.blueAccent.shade100, Colors.greenAccent.shade100, Colors.redAccent.shade100, Colors.purpleAccent.shade100,
      Colors.orangeAccent.shade100, Colors.tealAccent.shade100, Colors.pinkAccent.shade100, Colors.lightBlueAccent.shade100,
      Colors.cyanAccent.shade100, Colors.amberAccent.shade100, Colors.indigoAccent.shade100
    ];
     List<Color> iconColors = [
      Colors.blueAccent.shade700, Colors.greenAccent.shade700, Colors.redAccent.shade700, Colors.purpleAccent.shade700,
      Colors.orangeAccent.shade700, Colors.tealAccent.shade700, Colors.pinkAccent.shade700, Colors.lightBlueAccent.shade700,
      Colors.cyanAccent.shade700, Colors.amberAccent.shade700, Colors.indigoAccent.shade700
    ];
    // Use modulo to cycle through colors based on icon's hash code
    return colors[hashCode % colors.length];
  }

 Color _getIconColor(IconData icon) {
     int hashCode = icon.hashCode;
     List<Color> iconColors = [
      Colors.blueAccent.shade700, Colors.green.shade700, Colors.redAccent.shade700, Colors.purpleAccent.shade700,
      Colors.orangeAccent.shade700, Colors.teal.shade700, Colors.pinkAccent.shade700, Colors.lightBlueAccent.shade700,
      Colors.cyan.shade700, Colors.amberAccent.shade700, Colors.indigoAccent.shade700
    ];
     return iconColors[hashCode % iconColors.length];
  }


  @override
  Widget build(BuildContext context) {
    // Conditional size for quick links vs grid items
    double cardWidth = isSmall ? 65 : double.infinity; // Adjust small width
    double cardHeight = isSmall ? 85 : 100; // Adjust small height
    double iconBgRadius = isSmall ? 18 : 22;
    double iconSize = isSmall ? 20 : 26;
    double fontSize = isSmall ? 10 : 12;

    return InkWell(
      onTap: item.onTap ?? () {
        // Default action if onTap is null
        print('Tapped on \${item.label}');
        // You might want to navigate or show a snackbar here
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('\${item.label} tapped!'),
              duration: const Duration(seconds: 1),
            ),
          );
      },
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 1,
        color: Colors.white, // Explicitly set card color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: iconBgRadius,
                backgroundColor: item.color ?? _getIconBackgroundColor(item.icon),
                child: Icon(
                  item.icon,
                  size: iconSize,
                  color: _getIconColor(item.icon), // Use white or a contrasting color
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.grey[800], // Darker grey for better contrast
                    fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
