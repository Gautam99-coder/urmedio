import 'package:flutter/material.dart';
import 'package:urmedio/widgets/bottom_navbar.dart'; // Import your custom BottomNavBar

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  /// Helper widget to build a single notification list tile
  Widget _buildNotificationTile(
      {required String title, required String time}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50], // Match the background color for the icon container
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.notifications_none, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample data for the notifications list
    final List<Map<String, String>> notifications = [
      {
        'title': 'Paracetamol now available at XYZ',
        'time': '10:30 AM',
      },
      {
        'title': 'Ibuprofen now available at ABC',
        'time': '11:45 AM',
      },
      {
        'title': 'Amoxicillin now available at PQR',
        'time': '12:15 PM',
      },
      {
        'title': 'Aspirin now available at LMN',
        'time': '1:30 PM',
      },
      {
        'title': 'Cetirizine now available at UVW',
        'time': '2:45 PM',
      },
      // Add more notifications here as needed
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationTile(
            title: notification['title']!,
            time: notification['time']!,
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(), // Reusable bottom navigation bar
    );
  }
}