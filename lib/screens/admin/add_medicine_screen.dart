// add_medicine.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart'; // Add this to your pubspec.yaml: uuid: ^4.0.0
import 'package:urmedio/models/medicine_data.dart'; // Import the service and model

// Helper for generating unique IDs
const uuid = Uuid();

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController(); // New

  bool _inStock = true;
  // State variable to hold the selected image file (for display)
  File? _selectedImageFile; 
  // Store the path as a string (can be an asset path or a temporary file path)
  String _imagePath = 'assets/images/pmed.png'; // Default asset path

  final picker = ImagePicker();

  @override
  void dispose() {
    _medicineNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _expiryDateController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
        // Using the path as the "imagePath" for the Medicine model
        // NOTE: In a real app, this file would need to be moved to a permanent
        // storage location (like local app storage or cloud).
        _imagePath = pickedFile.path;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveMedicine() {
    if (_formKey.currentState!.validate()) {
      final newMedicine = Medicine(
        id: uuid.v4(),
        name: _medicineNameController.text,
        details: _descriptionController.text.isEmpty
            ? 'Generic Details'
            : _descriptionController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        expiryDate: _expiryDateController.text,
        imagePath: _imagePath,
        category: _categoryController.text.isEmpty
            ? 'Other'
            : _categoryController.text,
      );

      medicineDataService.addMedicine(newMedicine);
      
      _showSnackbar('Medicine "${newMedicine.name}" successfully added! 🎉');
      Navigator.pop(context); // Go back after adding
    }
  }

  Widget _buildImageContent() {
    if (_selectedImageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          _selectedImageFile!,
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Upload Medicine Image'),
          const SizedBox(height: 5),
          const Text(
            'Tap to upload',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text('Upload'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Stock',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Medicine Image',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildImageContent(),
                ),
              ),
              const SizedBox(height: 20),
              // --- Text Fields with Validation ---
              _buildTextField(
                controller: _medicineNameController,
                label: 'Medicine Name',
                validator: (value) => value!.isEmpty ? 'Please enter medicine name' : null,
              ),
              _buildTextField(
                controller: _priceController,
                label: 'Price (₹)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a price';
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
              ),
              _buildTextField(
                controller: _quantityController,
                label: 'Quantity Available',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter quantity';
                  if (int.tryParse(value) == null) return 'Invalid integer';
                  return null;
                },
              ),
              _buildTextField(
                controller: _categoryController,
                label: 'Category (e.g., Painkillers, Antibiotics)',
              ),
              _buildTextField(
                controller: _expiryDateController,
                label: 'Expiry Date',
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    // Simple format: DD/MM/YYYY
                    _expiryDateController.text =
                        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                  }
                },
                validator: (value) => value!.isEmpty ? 'Please select an expiry date' : null,
              ),
              _buildTextField(
                controller: _descriptionController,
                label: 'Details (e.g., Acetaminophen • 500mg • GSK)',
                maxLines: 5,
              ),
              // --- In Stock Switch ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'In Stock',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _inStock,
                    onChanged: (bool value) {
                      setState(() {
                        _inStock = value;
                        // For simplicity, we directly set quantity to 0 if out of stock
                        if (!value) {
                          _quantityController.text = '0';
                        }
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // --- Save Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveMedicine,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // --- Cancel Button ---
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    Widget? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator, // Added validator
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator, // Applied validator
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}