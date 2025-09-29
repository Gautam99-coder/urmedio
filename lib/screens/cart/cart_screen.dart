import 'package:flutter/material.dart';
import 'package:urmedio/widgets/bottom_navbar.dart'; // Import the custom BottomNavBar

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.black : Colors.grey[850],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  const _CartItem(
                    imagePath: 'assets/images/med1.png',
                    name: 'Pain Relief Tablets',
                    detail: '100mg',
                    quantity: 2,
                  ),
                  const SizedBox(height: 20),
                  const _CartItem(
                    imagePath: 'assets/images/med2.png',
                    name: 'Cold & Flu Capsules',
                    detail: '500mg',
                    quantity: 1,
                  ),
                  const SizedBox(height: 20),
                  const _CartItem(
                    imagePath: 'assets/images/med3.png',
                    name: 'Allergy Relief Pills',
                    detail: '200mg',
                    quantity: 3,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Summary',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Subtotal', 'Rs. 80.00'),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Shipping', 'Rs. 30.00'),
                  const Divider(height: 32, thickness: 1),
                  _buildSummaryRow('Total', 'Rs. 110.00', isTotal: true),
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
                    backgroundColor: const Color.fromARGB(255, 19, 40, 77),
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
class _CartItem extends StatefulWidget {
  final String name;
  final String detail;
  final int quantity;
  final String imagePath;

  const _CartItem({
    required this.name,
    required this.detail,
    required this.quantity,
    required this.imagePath,
  });

  @override
  State<_CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<_CartItem> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image from asset path
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            widget.imagePath, // Use the image path here
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        // Product Name and Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                widget.detail,
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
                '$_quantity',
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
