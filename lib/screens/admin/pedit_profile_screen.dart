import 'package:flutter/material.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Name
            Center(
              child: Column(
                children: [
                  // You'll need an asset for the profile picture
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile_avatar.png'), // Replace with your image asset path
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Gautam Tharu',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle change profile photo
                    },
                    child: const Text(
                      'Change Profile Photo',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Personal Information Section
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildTextField(context, 'Name', 'John Doe'),
            const SizedBox(height: 15),
            _buildTextField(context, 'Email', 'john.doe@example.com'),
            const SizedBox(height: 15),
            _buildTextField(context, 'Phone Number', '+123 456 7890'),
            const SizedBox(height: 30),

            // Pharmacy Information Section
            const Text(
              'Pharmacy Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildTextField(context, 'Pharmacy Name', 'MediCare Pharmacy'),
            const SizedBox(height: 15),
            _buildTextField(context, 'Pharmacy Address', '123 Main St, City, Country'),
            const SizedBox(height: 15),
            _buildTextField(context, 'Pharmacy Contact', '+123 987 6543'),
            const SizedBox(height: 30),

            // Save Changes Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle save changes
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: PBottomNavBar(selectedIndex: 0, onItemTapped: (int index) {  },)
    );
  }

  Widget _buildTextField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}