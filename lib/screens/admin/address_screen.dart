// lib/add_address_screen.dart

import 'package:flutter/material.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CHANGE 1: Switched background to white
      backgroundColor: Colors.white,
      appBar: AppBar(
        // CHANGE 2: Switched AppBar background to white
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // CHANGE 3: Changed icon color to black for visibility on a light background
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Address',
          style: TextStyle(
            // CHANGE 4: Changed title color to black
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Use a helper widget for each text field
              _buildTextField(
                label: 'Address Line 1',
                hint: 'Enter address',
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: 'Address Line 2 (Optional)',
                hint: 'Enter address',
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: 'City',
                hint: 'Enter city',
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: 'State/Region',
                hint: 'Enter state/region',
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: 'Postal Code',
                hint: 'Enter postal code',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: 'Country',
                hint: 'Enter country',
              ),
              const SizedBox(height: 40),

              // Save Address Button (No changes needed here)
              ElevatedButton(
                onPressed: () {
                  // Handle save address logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052D4), // Blue button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A helper widget to create a labeled text field, avoiding repetitive code.
  Widget _buildTextField({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            // CHANGE 5: Changed label color to black
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black87), // Input text color
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            // CHANGE 6: Changed fill color to a light grey to stand out on the white background
            fillColor: const Color(0xFFF7F8F9),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300), // Added a subtle border
            ),
              enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300), // Subtle border when not focused
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5), // Highlight border when focused
            )
          ),
        ),
      ],
    );
  }
}