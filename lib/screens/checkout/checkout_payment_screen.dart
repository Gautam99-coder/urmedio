import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Define a variable to hold the currently selected payment option.
  // We'll use a String to represent the selected method (e.g., 'Credit Card', 'Razorpay').
  String _selectedPaymentMethod = 'Credit Card';

  // A helper method for the custom TextField style
  Widget _buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 17, 64, 101), width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  // A helper method for the payment method options
  Widget _buildPaymentOption(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedPaymentMethod == title ? const Color.fromARGB(255, 16, 58, 93) : Colors.grey.shade300,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? value) {
          // Use setState to update the selected option and rebuild the UI
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

  // A helper method for the summary rows
  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isTotal ? Colors.black : Colors.grey[700],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  // A helper method for the "Continue" button
  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/confmPage');
            // Add navigation or payment logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 19, 40, 77),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Continue to Payment',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            'Checkout',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping Address Section
            const Text(
              'Shipping Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTextField('Address'),
            const SizedBox(height: 16),
            _buildTextField('City'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('State')),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Zip Code')),
              ],
            ),
            const SizedBox(height: 32),

            // Payment Method Section
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Call the builder methods for the selectable options
            _buildPaymentOption('Credit Card'),
            const SizedBox(height: 12),
            _buildPaymentOption('Razorpay'),
            const SizedBox(height: 32),

            // Order Summary Section
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
      bottomNavigationBar: _buildContinueButton(),
    );
  }
}