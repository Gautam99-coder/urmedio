// lib/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:urmedio/theme/colors.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart'; // <-- Import your custom nav bar

class AprofileScreen extends StatefulWidget {
  const AprofileScreen({super.key});

  @override
  State<AprofileScreen> createState() => _AprofileScreenState();
}

class _AprofileScreenState extends State<AprofileScreen> {
  // The Profile tab is the 4th item, so its index is 3.
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    // NOTE: In a real app, this is where you would navigate to other pages.
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // This ensures no back arrow will be automatically added
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      // The body of the screen remains the same
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            const CircleAvatar(
              radius: 50,
              // Uses the new image path you provided
              backgroundImage: AssetImage('assets/images/avater2.jpeg'),
            ),
            const SizedBox(height: 12),
            // User Name
            const Text(
              'Dr. Ram',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            // User Email
            Text(
              'drdoom@email.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 30),
            // Menu Items
            _buildProfileMenuItem(title: 'Edit Profile', onTap: () {
              Navigator.pushNamed(context, '/aeditp');
            }),
            _buildProfileMenuItem(title: 'Change Password', onTap: () {
              Navigator.pushNamed(context, '/forgetPass');
            }),
            _buildProfileMenuItem(title: 'Earnings', onTap: () {
              Navigator.pushNamed(context, '/earning');
            }),
            _buildProfileMenuItem(title: 'Settings', onTap: () {
              Navigator.pushNamed(context, '/settingScr');
            }),
            _buildProfileMenuItem(title: 'Location', onTap: () {
              Navigator.pushNamed(context, '/plocation');
            }),
            const SizedBox(height: 30),
            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButton,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // Use the custom bottom navigation bar
      bottomNavigationBar: PBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildProfileMenuItem(
      {required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade800,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}