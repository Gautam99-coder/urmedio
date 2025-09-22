// lib/pedit_profile_screen.dart

import 'dart:io'; // Required for using the 'File' type
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Required for picking images

// CHANGE 1: Converted from StatelessWidget to StatefulWidget
class PeditProfileScreen extends StatefulWidget {
  const PeditProfileScreen({super.key});

  @override
  State<PeditProfileScreen> createState() => _PeditProfileScreenState();
}

class _PeditProfileScreenState extends State<PeditProfileScreen> {
  // This variable will hold the image file the user picks.
  File? _imageFile;

  // This function handles the logic for opening the gallery and picking an image.
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Use the gallery as the image source.
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // If the user successfully picks a file, update the UI.
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

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
                    CircleAvatar(
                      radius: 50,
                      // CHANGE 2: The background image now updates dynamically.
                      // If an image is picked (_imageFile is not null), it shows the new image.
                      // Otherwise, it shows the default avatar.
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) as ImageProvider
                          : const AssetImage('assets/images/avatar.jpeg'),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ram Prakash Kurmi',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      // CHANGE 3: The button now calls the _pickImage function.
                      onPressed: _pickImage,
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

              // Personal Information Section (NO CHANGES HERE)
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildTextField(context, 'Name', 'Ram'),
              const SizedBox(height: 15),
              _buildTextField(context, 'Email', 'drdoom@gmail.com'),
              const SizedBox(height: 15),
              _buildTextField(context, 'Phone Number', '+123 456 7890'),
              const SizedBox(height: 30),

              // Pharmacy Information Section (NO CHANGES HERE)
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
              _buildTextField(
                  context, 'Pharmacy Address', '123 Main St, City, Country'),
              const SizedBox(height: 15),
              _buildTextField(context, 'Pharmacy Contact', '+123 987 6543'),
              const SizedBox(height: 30),

              // Save Changes Button (NO CHANGES HERE)
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
     );
  }

  // Your helper widget is unchanged.
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