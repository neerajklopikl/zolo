import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';
import '../widgets/dashboard_grid.dart';
import '../widgets/quick_links_row.dart';
import '../widgets/recent_transactions_row.dart';
import '../widgets/section_header.dart';


class TransactionDetailsTab extends StatelessWidget {
  const TransactionDetailsTab({super.key});

  // --- Define Data Here (or pass it in) ---
  // In a real app, this data might come from a state management solution or API

  static final List<DashboardItem> _quickLinks = [
    DashboardItem(icon: Icons.add_circle_outline, label: 'Add Txn'),
    DashboardItem(icon: Icons.bar_chart, label: 'Sale Report'),
    DashboardItem(icon: Icons.folder_shared, label: 'Masters'),
    DashboardItem(icon: Icons.receipt_long, label: 'All Txns'),
  ];

  static final List<DashboardItem> _recentTxnRow = [
    DashboardItem(icon: Icons.description_outlined, label: 'Invoices'),
    DashboardItem(icon: Icons.request_quote_outlined, label: 'Quotation'),
    DashboardItem(icon: Icons.shopping_cart_outlined, label: 'Purchase'),
  ];

  static final List<DashboardItem> _otherDocuments = [
    DashboardItem(icon: Icons.qr_code_scanner, label: 'e-Invoice'),
    DashboardItem(icon: Icons.local_shipping_outlined, label: 'e-Way Bills'),
    DashboardItem(icon: Icons.text_snippet_outlined, label: 'Proforma Invoices'),
    DashboardItem(icon: Icons.receipt_long_outlined, label: 'Payment Receipts'),
    DashboardItem(icon: Icons.payment_outlined, label: 'Payments Made'),
    DashboardItem(icon: Icons.money_off_outlined, label: 'Debit Notes'),
    DashboardItem(icon: Icons.add_card_outlined, label: 'Credit Notes'),
    DashboardItem(icon: Icons.devices_other_outlined, label: 'Digital Docs'), // Example
    DashboardItem(icon: Icons.delivery_dining_outlined, label: 'Delivery Challans'),
    DashboardItem(icon: Icons.inventory_2_outlined, label: 'Inventory'),
    DashboardItem(icon: Icons.book_outlined, label: 'Ledgers'),
    DashboardItem(icon: Icons.assessment_outlined, label: 'Reports'),
    DashboardItem(icon: Icons.account_balance_wallet_outlined, label: 'Expenses'),
    DashboardItem(icon: Icons.replay_circle_filled_outlined, label: 'Refund Voucher'),
    DashboardItem(icon: Icons.list_alt_outlined, label: 'Purchase Orders'),
    DashboardItem(icon: Icons.grid_on_outlined, label: 'GST Reports'), // Example
  ];

   static final List<DashboardItem> _moreItems = [
    DashboardItem(icon: Icons.card_giftcard_outlined, label: 'Festive Greetings'),
    DashboardItem(icon: Icons.format_list_numbered_outlined, label: 'HSN/SAC'),
    DashboardItem(icon: Icons.qr_code_2_outlined, label: 'E-Invoice QR'),
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Quick Links ---
            const SectionHeader(title: 'Quick Links'),
            QuickLinksRow(quickLinks: _quickLinks),
            const SizedBox(height: 15),

            // --- Recent Transactions ---
            const SectionHeader(title: 'Recent Transactions'),
            // You would replace this with actual transaction data list
            Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: Text(
                  'No recent transactions found.\nCreate a new one to get started.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
               ),
            ),
            const SizedBox(height: 5),
            RecentTransactionsRow(items: _recentTxnRow),
            const SizedBox(height: 15),

            // --- Other Documents ---
            const SectionHeader(title: 'Other Documents'),
            DashboardGrid(items: _otherDocuments, crossAxisCount: 4), // Specify columns
            const SizedBox(height: 15),

            // --- More ---
            const SectionHeader(title: 'More'),
            DashboardGrid(items: _moreItems, crossAxisCount: 4), // Specify columns
            const SizedBox(height: 20), // Add some bottom padding
          ],
        ),
      ),
    );
  }
}
