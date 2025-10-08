// lib/add_address_screen.dart

import 'package:flutter/material.dart';

// Converted to StatefulWidget to handle Form validation and controllers
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  // Global key for the form to manage validation state
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture user input
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void dispose() {
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with saving logic
      _formKey.currentState!.save();

      // Simulate saving data (e.g., to a database or shared preferences)
      String savedAddress = 
          '${_addressLine1Controller.text}, ${_cityController.text}, ${_postalCodeController.text}';
      
      // Show success popup
      _showSnackbar('Address successfully saved! 🗺️');

      // Optionally navigate back after a successful save
      // Navigator.of(context).pop(); 
    }
  }

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
      body: Form(
        key: _formKey, // Attach the form key
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Use a helper widget for each text field
                _buildTextField(
                  controller: _addressLine1Controller,
                  label: 'Address Line 1',
                  hint: 'Enter street name and house number',
                  validator: (value) => value!.isEmpty ? 'Address Line 1 is required' : null,
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _addressLine2Controller,
                  label: 'Address Line 2 (Optional)',
                  hint: 'Enter apartment, suite, etc.',
                  validator: null, // Optional field, no required validation
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _cityController,
                  label: 'City',
                  hint: 'Enter city',
                  validator: (value) => value!.isEmpty ? 'City is required' : null,
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _stateController,
                  label: 'State/Region',
                  hint: 'Enter state/region',
                  validator: (value) => value!.isEmpty ? 'State/Region is required' : null,
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _postalCodeController,
                  label: 'Postal Code',
                  hint: 'Enter postal code',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Postal Code is required';
                    if (value.length < 5) return 'Must be at least 5 digits';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  hint: 'Enter country',
                  validator: (value) => value!.isEmpty ? 'Country is required' : null,
                ),
                const SizedBox(height: 40),

                // Save Address Button
                ElevatedButton(
                  onPressed: _saveAddress, // Call the validation and save logic
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
      ),
    );
  }

  /// A helper widget to create a labeled text field with validation and controller.
  Widget _buildTextField({
    required TextEditingController controller, // Added controller
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator, // Added validator function
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
        TextFormField( // Switched to TextFormField for validation
          controller: controller, // Attached controller
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black87), // Input text color
          validator: validator, // Attached validator
          decoration: InputDecoration(
            hintText: hint,
            errorStyle: const TextStyle(fontSize: 12), // Smaller error text
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
            ),
            errorBorder: OutlineInputBorder( // Red border on error
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder( // Red border on error, focused
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}