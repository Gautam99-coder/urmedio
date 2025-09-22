import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationServicesEnabled = true;

  // Helper widget to build a toggle setting item
  Widget _buildToggleSetting({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  // Helper widget to build a navigation-style setting item
  Widget _buildNavigationSetting({
    required String title,
    String? value, // Optional value for items like App Version
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (value != null)
                Text(
                  value,
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
              if (onTap != null)
                const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Toggles
            _buildToggleSetting(
              icon: Icons.notifications_none,
              title: 'Notifications',
              description: 'Enable push notifications for updates and reminders',
              value: _notificationsEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _notificationsEnabled = newValue;
                });
              },
            ),
            const SizedBox(height: 10),
            _buildToggleSetting(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              description: 'Switch to a darker color scheme for better visibility at night',
              value: _darkModeEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _darkModeEnabled = newValue;
                });
              },
            ),
            const SizedBox(height: 10),
            _buildToggleSetting(
              icon: Icons.location_on_outlined,
              title: 'Location Services',
              description: 'Allow the app to access your location for nearby pharmacy',
              value: _locationServicesEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _locationServicesEnabled = newValue;
                });
              },
            ),
            const SizedBox(height: 32),

            // Help & Support Section
            Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildNavigationSetting(
              title: 'Contact Us',
              onTap: () {
                Navigator.pushNamed(context, '/contactUs');
                // Navigate to Contact Us screen
                // Navigator.pushNamed(context, '/contactUs');
              },
            ),
            _buildNavigationSetting(
              title: 'FAQ',
              onTap: () {
                Navigator.pushNamed(context, '/faq');
                // Navigate to FAQ screen
                // Navigator.pushNamed(context, '/faq');
              },
            ),
            const SizedBox(height: 32),

            // About Section
            Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildNavigationSetting(
              title: 'App Version',
              value: '1.2.3', // Static value for app version
            ),
            _buildNavigationSetting(
              title: 'Terms of Service',
              onTap: () {
                Navigator.pushNamed(context, '/tos');
                // Navigate to Terms of Service screen
                // Navigator.pushNamed(context, '/termsOfService');
              },
            ),
            _buildNavigationSetting(
              title: 'Privacy Policy',
              onTap: () {
                Navigator.pushNamed(context, '/pp');
                // Navigate to Privacy Policy screen
                // Navigator.pushNamed(context, '/privacyPolicy');
              },
            ),
          ],
        ),
      ),
    );
  }
}