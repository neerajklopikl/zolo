import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';
import 'dashboard_card.dart';

class QuickLinksRow extends StatelessWidget {
  final List<DashboardItem> quickLinks;
  final VoidCallback? onShowAllTap;

  const QuickLinksRow({
    super.key,
    required this.quickLinks,
    this.onShowAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95, // Adjust height to fit cards + padding
      child: Row(
        // Use Expanded for items to distribute space, or adjust MainAxisAlignment
        children: [
          ...quickLinks.map((item) => Expanded( // Use Expanded for equal spacing
                child: Padding(
                   padding: const EdgeInsets.only(right: 6.0), // Add spacing between items
                   child: DashboardItemCard(item: item, isSmall: true),
                ),
              )).toList(),
          // Show All Arrow Button
          InkWell(
            onTap: onShowAllTap ?? () => print("Show All Tapped!"),
            borderRadius: BorderRadius.circular(10),
            child: Card(
              elevation: 1,
              color: Colors.blueAccent, // Color from video
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: 65, // Match isSmall card width
                height: 85, // Match isSmall card height
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
