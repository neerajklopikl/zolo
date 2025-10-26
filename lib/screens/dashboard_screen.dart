import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tabs/transaction_details_tab.dart'; // Import the tab content

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- Logout Function ---
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background consistent
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        shadowColor: Colors.grey.shade300, // Softer shadow
        leadingWidth: 150, // Adjust as needed
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueAccent,
                child: Text('C', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 8),
              Expanded( // Allow text to wrap if needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chetan', // Replace with user name
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Registered',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                       overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.orange.shade700),
             tooltip: 'Refresh',
            onPressed: () {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Refreshing...'), duration: Duration(seconds: 1)),
               );
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.orange.shade700, size: 28),
            tooltip: 'Create',
            onPressed: () {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Create action!'), duration: Duration(seconds: 1)),
               );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black54),
            tooltip: 'Log Out',
            onPressed: _logout,
          ),
          const SizedBox(width: 10),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.redAccent[700],
          unselectedLabelColor: Colors.grey[700],
          indicatorColor: Colors.redAccent[700],
          indicatorWeight: 3.0,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          tabs: const [
            Tab(text: 'Transaction Details'),
            Tab(text: 'Party Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // --- Transaction Details Tab ---
          TransactionDetailsTab(),

          // --- Party Details Tab (Placeholder) ---
          Center(child: Text('Party Details Content Placeholder')),
        ],
      ),
    );
  }
}
