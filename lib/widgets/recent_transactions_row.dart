import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';
import 'dashboard_card.dart';

class RecentTransactionsRow extends StatelessWidget {
  final List<DashboardItem> items;

  const RecentTransactionsRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((item) => Flexible( // Use Flexible instead of Expanded if width varies
            child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add spacing
               child: DashboardItemCard(item: item),
            ),
          )).toList(),
    );
  }
}
