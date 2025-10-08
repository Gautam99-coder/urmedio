// UpdateStockScreen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';

class UpdateStockScreen extends StatefulWidget {
  const UpdateStockScreen({Key? key}) : super(key: key);

  @override
  State<UpdateStockScreen> createState() => _UpdateStockScreenState();
}

class _UpdateStockScreenState extends State<UpdateStockScreen> {
  // Global key for the form to handle validation
  final _formKey = GlobalKey<FormState>(); 

  final TextEditingController _medicineNameController =
      TextEditingController(text: 'Paracetamol');
  final TextEditingController _priceController =
      TextEditingController(text: '150');
  final TextEditingController _quantityController =
      TextEditingController(text: '12');
  final TextEditingController _expiryDateController =
      TextEditingController(text: '09-12-2027');
  final TextEditingController _descriptionController = TextEditingController(
      text:
          'Paracetamol is a common pain reliever and fever reducer. It\'s also used to prevent blood clots, reducing the risk of heart attacks and strokes.');

  bool _inStock = true;
  File? _image;
  final String _initialImagePath = 'assets/images/med1.png';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _medicineNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _expiryDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Form is valid!
      _formKey.currentState!.save();

      // Implement your data update logic here (e.g., calling your MedicineDataService)

      // Show success popup
      _showSnackbar('Stock for ${_medicineNameController.text} updated successfully! ✅');
      
      // Optionally navigate back after saving:
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Stock',
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
        key: _formKey, // Attach the form key
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
                child: DottedBorder(
                  // color: Colors.grey, // Re-enabled DottedBorder properties to display it
                  // strokeWidth: 2,
                  // borderType: BorderType.RRect,
                  // radius: const Radius.circular(10),
                  // dashPattern: const [8, 4],
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _image != null
                            ? Image.file(_image!, fit: BoxFit.cover)
                            : Image.asset(_initialImagePath, fit: BoxFit.cover),
                        Container(
                          color: Colors.black.withOpacity(0.5), // Dark overlay
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Upload Medicine Image',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Tap to upload',
                              style: TextStyle(color: Colors.white70),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // --- Text Fields with Validation ---
              _buildTextField(
                controller: _medicineNameController,
                label: 'Medicine Name',
                validator: (value) => value!.isEmpty ? 'Medicine Name is required' : null,
              ),
              _buildTextField(
                controller: _priceController,
                label: 'Price (₹)',
                keyboardType: TextInputType.number,
                prefixText: 'Rs. ',
                validator: (value) {
                  if (value!.isEmpty) return 'Price is required';
                  if (double.tryParse(value) == null) return 'Invalid price format';
                  return null;
                },
              ),
              _buildTextField(
                controller: _quantityController,
                label: 'Quantity Available',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Quantity is required';
                  if (int.tryParse(value) == null) return 'Invalid quantity format';
                  return null;
                },
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
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _expiryDateController.text =
                          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                    });
                  }
                },
                validator: (value) => value!.isEmpty ? 'Expiry Date is required' : null,
              ),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 5,
                // Description is considered optional for simple validation
              ),
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
              // --- Save Button calls _saveChanges ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges, // Use the new save method
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

  // --- UPDATED _buildTextField method to use TextFormField and support validation ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    Widget? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
    String? prefixText,
    String? Function(String?)? validator, // Added validator parameter
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
          TextFormField( // Switched to TextFormField
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator, // Apply validator
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixText: prefixText,
              // Error style for validation messages
              errorStyle: const TextStyle(color: Colors.red),
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
              errorBorder: OutlineInputBorder( // Red border on validation error
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder( // Red border when focused and in error
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 2),
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