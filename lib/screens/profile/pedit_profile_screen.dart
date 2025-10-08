// lib/pedit_profile_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PeditProfileScreen extends StatefulWidget {
  const PeditProfileScreen({super.key});

  @override
  State<PeditProfileScreen> createState() => _PeditProfileScreenState();
}

class _PeditProfileScreenState extends State<PeditProfileScreen> {
  File? _imageFile;

  final _formKey = GlobalKey<FormState>();

  // Controllers for all editable fields
  final _nameController = TextEditingController(text: 'Ram');
  final _emailController = TextEditingController(text: 'drdoom@gmail.com');
  final _phoneController = TextEditingController(text: '+123 456 7890');
  final _pharmacyNameController =
      TextEditingController(text: 'MediCare Pharmacy');
  final _pharmacyAddressController =
      TextEditingController(text: '123 Main St, City, Country');
  final _pharmacyContactController =
      TextEditingController(text: '+123 987 6543');

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // ✅ Added Form for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : const AssetImage('assets/images/avater2.jpeg')
                              as ImageProvider,
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ram Prakash Kurmi',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
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

              // Personal Information
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildValidatedTextField('Name', _nameController,
                  validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              }),
              const SizedBox(height: 15),
              _buildValidatedTextField('Email', _emailController,
                  validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              }),
              const SizedBox(height: 15),
              _buildValidatedTextField('Phone Number', _phoneController,
                  validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!RegExp(r'^[0-9+\s-]{10,}$').hasMatch(value)) {
                  return 'Enter a valid phone number';
                }
                return null;
              }),
              const SizedBox(height: 30),

              // Pharmacy Information
              const Text(
                'Pharmacy Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildValidatedTextField(
                  'Pharmacy Name', _pharmacyNameController,
                  validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter pharmacy name';
                }
                return null;
              }),
              const SizedBox(height: 15),
              _buildValidatedTextField(
                  'Pharmacy Address', _pharmacyAddressController,
                  validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter pharmacy address';
                }
                return null;
              }),
              const SizedBox(height: 15),
              _buildValidatedTextField(
                  'Pharmacy Contact', _pharmacyContactController,
                  validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter pharmacy contact';
                }
                if (!RegExp(r'^[0-9+\s-]{10,}$').hasMatch(value)) {
                  return 'Enter a valid contact number';
                }
                return null;
              }),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Text field builder with validation
  Widget _buildValidatedTextField(
      String label, TextEditingController controller,
      {String? Function(String?)? validator}) {
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
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
}
