import 'package:flutter/material.dart';
import 'package:urmedio/models/address_model.dart';
 // Import the Address model

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _line2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  // Simple validation logic
  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      // Create a new Address object
      final newAddress = Address(
        line1: _line1Controller.text.trim(),
        line2: _line2Controller.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        postalCode: _postalCodeController.text.trim(),
        country: _countryController.text.trim(),
      );

      // Pass the new address back to the previous screen
      Navigator.of(context).pop(newAddress);
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up memory
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color.fromARGB(255, 20, 40, 95);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add New Address',
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AddressInputField(
                label: 'Address Line 1',
                hintText: 'Enter address',
                controller: _line1Controller,
                validator: _requiredValidator, // Added validation
              ),
              _AddressInputField(
                label: 'Address Line 2 (Optional)',
                hintText: 'Enter address',
                controller: _line2Controller,
                validator: (value) => null, // Optional field has no validation
              ),
              _AddressInputField(
                label: 'City',
                hintText: 'Enter city',
                controller: _cityController,
                validator: _requiredValidator, // Added validation
              ),
              _AddressInputField(
                label: 'State/Region',
                hintText: 'Enter state/region',
                controller: _stateController,
                validator: _requiredValidator, // Added validation
              ),
              _AddressInputField(
                label: 'Postal Code',
                hintText: 'Enter postal code',
                controller: _postalCodeController,
                validator: _requiredValidator, // Added validation
                keyboardType: TextInputType.number,
              ),
              _AddressInputField(
                label: 'Country',
                hintText: 'Enter country',
                controller: _countryController,
                validator: _requiredValidator, // Added validation
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveAddress, // Call the save logic
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modified to use a TextFormField for validation and accept a controller
class _AddressInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const _AddressInputField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator, // Applied the validator
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              errorStyle: const TextStyle(height: 0.5), // Compact error message
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color.fromARGB(255, 20, 40, 95), width: 2), // Highlight on focus
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1), // Highlight on error
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}