import 'package:flutter/material.dart';
import 'package:urmedio/theme/colors.dart';
import 'package:urmedio/widgets/bottom_navbar.dart'; // Import the custom BottomNavBar widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// Helper widget to build the profile option list tiles
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap, // Add a new onTap callback
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell( // Use InkWell for tap detection with a ripple effect
        onTap: onTap, // Pass the onTap callback to InkWell
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black54),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define the primary blue color from the UI
    const primaryBlue=AppColors.primaryButton;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {
              Navigator.pushNamed(context, '/settingScr');
              // Handle settings tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Profile Picture
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 46,
                  backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                ),
              ),
              const SizedBox(height: 16),
              // User Name, Email, and Phone
              const Text(
                'Ram Prakash Kurmi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'ram100@gmail.com',
                style: TextStyle(fontSize: 16, color: primaryBlue),
              ),
              const SizedBox(height: 4),
              const Text(
                '+977-123456789',
                style: TextStyle(fontSize: 16, color: primaryBlue),
              ),
              const SizedBox(height: 24),
              // Edit Profile Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/editPro');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 32),
              // Profile Options List
              _buildProfileOption(
                icon: Icons.inventory_2_outlined,
                title: 'My Orders',
                onTap: () {
                  Navigator.pushNamed(context, '/myorder');
                },
              ),
              _buildProfileOption(
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
                onTap: () {
                  Navigator.pushNamed(context, '/saveAdd');
                },
              ),
              _buildProfileOption(
                icon: Icons.my_location,
                title: 'Current Location',
                onTap: () {
                  Navigator.pushNamed(context, '/saveAdd');
                },
              ),
              _buildProfileOption(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  Navigator.pushNamed(context, '/contactUs');
                },
              ),
              _buildProfileOption(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy & Terms',
                onTap: () {
                  Navigator.pushNamed(context, '/pp');
                },
              ),
              _buildProfileOption(
                icon: Icons.key_outlined,
                title: 'Change Password',
                onTap: () {
                  Navigator.pushNamed(context, '/forgetPass');
                },
              ),
              const SizedBox(height: 32),
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                    // Implement logout logic, e.g., clear user session and navigate to login screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Logout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // Reusable bottom nav bar
    );
  }
}