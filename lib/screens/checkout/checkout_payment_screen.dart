import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urmedio/theme/colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // 1. Add a GlobalKey for the Form
  final _formKey = GlobalKey<FormState>();

  // Controllers for address fields
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  // Controllers for credit card fields
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  String _selectedPaymentMethod = 'Credit Card';

  @override
  void dispose() {
    // Dispose all controllers to free up resources
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
              const Icon(Icons.check_circle, color: AppColors.info, size: 80),
              const SizedBox(height: 20),
              const Text('Order Confirmed!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Your order has been placed successfully.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryButton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('VIEW CONFIRMATION',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/confmPage');
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // A helper method for text fields that now uses TextFormField
  Widget _buildTextFormField(String hintText, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 17, 64, 101), width: 2.0)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      // Simple "not empty" validation
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }

  // Helper for payment options, now with an icon
  Widget _buildPaymentOption(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedPaymentMethod == title
              ? const Color.fromARGB(255, 16, 58, 93)
              : Colors.grey.shade300,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        title: Row(
          children: [
            Icon(icon, color: Colors.grey[800]),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              _selectedPaymentMethod = value;
            });
          }
        },
        selected: _selectedPaymentMethod == title,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        activeColor: const Color.fromARGB(255, 13, 51, 82),
      ),
    );
  }

  // 2. ADDED: A new widget for the conditional Credit Card form
  Widget _buildCreditCardForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Card Details',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800])),
          const SizedBox(height: 12),
          _buildTextFormField('Card Number', _cardNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16)
              ]),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _buildTextFormField(
                      'Expiry Date (MM/YY)', _expiryDateController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [LengthLimitingTextInputFormatter(5)])),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildTextFormField('CVV', _cvvController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 16,
                color: isTotal ? Colors.black : Colors.grey[700],
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(amount,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Helper for the continue button
  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // 3. UPDATED: Validate the form before proceeding
            if (_formKey.currentState!.validate()) {
              _showConfirmationDialog();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 19, 40, 77),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text('Continue to Payment',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(
          child: Text('Checkout',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // 4. WRAPPED: The main column is now a Form
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Shipping Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildTextFormField('Address', _addressController),
              const SizedBox(height: 16),
              _buildTextFormField('City', _cityController),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextFormField('State', _stateController)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildTextFormField('Zip Code', _zipController,
                          keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildPaymentOption('Credit Card', Icons.credit_card),
              const SizedBox(height: 12),
              _buildPaymentOption('Razorpay', Icons.api), // Using a generic API icon
              const SizedBox(height: 16),

              // 5. ADDED: Conditional display of the credit card form
              if (_selectedPaymentMethod == 'Credit Card')
                _buildCreditCardForm(),

              const SizedBox(height: 32),
              const Text('Order Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildSummaryRow('Subtotal (2 items)', 'Rs. 45.00'),
              const SizedBox(height: 8),
              _buildSummaryRow('Shipping', 'Rs. 5.00'),
              const SizedBox(height: 8),
              _buildSummaryRow('Tax', 'Rs. 3.50'),
              const Divider(height: 24, thickness: 1),
              _buildSummaryRow('Total', 'Rs. 53.50', isTotal: true),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildContinueButton(),
    );
  }
}