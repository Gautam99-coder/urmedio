import 'package:flutter/material.dart';
import 'package:urmedio/theme/colors.dart';
// Assuming AppColors is available from this import, or replace with hardcoded color
// import 'package:urmedio/theme/colors.dart'; 
import 'package:urmedio/widgets/bottom_navbar.dart'; 

// --- Cart Item Data Model (for demonstration) ---
// In a real app, this would come from the Medicine model, but we define it here 
// to work with the static list inside the CartScreen.
class CartItemData {
  final String name;
  final String detail;
  int quantity; // Can change
  final String imagePath;
  final double price; // Price per unit

  CartItemData({
    required this.name,
    required this.detail,
    required this.quantity,
    required this.imagePath,
    required this.price,
  });
}

// --- CartScreen (Converted to StatefulWidget) ---
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Hardcoded data list with unit prices
  final List<CartItemData> _cartItems = [
    CartItemData(
      imagePath: 'assets/images/med1.png',
      name: 'Pain Relief Tablets',
      detail: '100mg',
      quantity: 2,
      price: 15.00, // Example Unit Price
    ),
    CartItemData(
      imagePath: 'assets/images/med2.png',
      name: 'Cold & Flu Capsules',
      detail: '500mg',
      quantity: 1,
      price: 20.00, // Example Unit Price
    ),
    CartItemData(
      imagePath: 'assets/images/med3.png',
      name: 'Allergy Relief Pills',
      detail: '200mg',
      quantity: 3,
      price: 10.00, // Example Unit Price
    ),
  ];

  final double _shippingCost = 30.00;

  // --- Calculation Logic ---
  double get _subtotal {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double get _total => _subtotal + _shippingCost;
  
  // --- Callback Function to handle quantity change from child widget ---
  void _updateQuantity(CartItemData item, int newQuantity) {
    setState(() {
      item.quantity = newQuantity;
      // State updated, _subtotal and _total getters will automatically recalculate
    });
  }

  /// Helper widget to build the rows in the summary section.
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[850],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the primary button color safely
    final primaryButtonColor = Theme.of(context).primaryColor; // Fallback to Theme primary color

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Dynamically generate cart items
                  ..._cartItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: _CartItem(
                          item: item,
                          onQuantityChanged: _updateQuantity,
                        ),
                      )),
                      
                  const SizedBox(height: 20),
                  
                  const Text(
                    'Summary',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // Summary Rows using dynamic calculations
                  _buildSummaryRow('Subtotal', 'Rs. ${_subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Shipping', 'Rs. ${_shippingCost.toStringAsFixed(2)}'),
                  const Divider(height: 32, thickness: 1),
                  _buildSummaryRow('Total', 'Rs. ${_total.toStringAsFixed(2)}', isTotal: true),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkoutPage');
                    // Add checkout logic
                  },
                  style: ElevatedButton.styleFrom(
                    // Using primaryButtonColor here as AppColors.primaryButton is inaccessible
                    backgroundColor: AppColors.primaryButton, 
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // Reusable bottom nav bar
    );
  }
}

/// A custom widget to represent a single item in the cart.
// Renamed to accept CartItemData and a callback
class _CartItem extends StatefulWidget {
  final CartItemData item;
  final Function(CartItemData item, int newQuantity) onQuantityChanged;

  const _CartItem({
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  State<_CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<_CartItem> {
  // Removed local _quantity; quantity is managed in the parent's data model

  void _increment() {
    int newQuantity = widget.item.quantity + 1;
    // Pass the change up to the parent widget
    widget.onQuantityChanged(widget.item, newQuantity);
  }

  void _decrement() {
    if (widget.item.quantity > 1) {
      int newQuantity = widget.item.quantity - 1;
      // Pass the change up to the parent widget
      widget.onQuantityChanged(widget.item, newQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image from asset path
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            // Use a light background color for the image container to match the UI visual
            color: Colors.orange.shade50, 
            child: Image.asset(
              widget.item.imagePath, // Use the image path here
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Product Name and Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                widget.item.detail,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),
        // Quantity Selector
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.remove, size: 20),
                onPressed: _decrement,
              ),
              Text(
                // Read quantity directly from the centralized data model
                '${widget.item.quantity}', 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.add, size: 20),
                onPressed: _increment,
              ),
            ],
          ),
        )
      ],
    );
  }
}