import 'package:flutter/material.dart';
import 'package:urmedio/models/order.dart'; // Import the model

class OrderSummaryScreen extends StatelessWidget {
  final Order order; // Accepts an Order object

  const OrderSummaryScreen({super.key, required this.order});

  // Helper method for payment and total rows
  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Helper method for the ordered item's description
  Widget _buildOrderItem(String imagePath, String name, String description, String details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                details,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F2FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order Summary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        children: [
          // Order Status Section (Dynamic)
          Text(
            order.status.displayTitle, // Dynamic Status Title
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: order.status.color, // Dynamic Status Color
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Order Date: ${order.date}', // Dynamic Date
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Order ID: ${order.id}', // Dynamic ID
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(thickness: 1, color: Colors.grey),
          const SizedBox(height: 24),

          // Payment Information Section (Dynamic)
          const Text(
            'Payment Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Payment Method', order.paymentMethod), // Dynamic Payment
          const SizedBox(height: 8),
          _buildSummaryRow('Total Amount', order.totalAmount), // Dynamic Amount
          const SizedBox(height: 24),
          const Divider(thickness: 1, color: Colors.grey),
          const SizedBox(height: 24),

          // Description Section (Dynamic)
          const Text(
            'Items Ordered',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Loop through all items in the order
          ...order.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildOrderItem(
                  item.imagePath,
                  item.name,
                  item.description,
                  item.details,
                ),
              )),
        ],
      ),
    );
  }
}