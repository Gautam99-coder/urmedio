// lib/widgets/medicine_item.dart

import 'package:flutter/material.dart';
import 'package:urmedio/models/medicine_data.dart'; // Import the model

class MedicineItem extends StatefulWidget {
  final Medicine medicine;
  final Function(String id) onDelete;
  final Function(String id, int newCount) onCountUpdate;
  final Function(String id) onEdit;

  const MedicineItem({
    Key? key,
    required this.medicine,
    required this.onDelete,
    required this.onCountUpdate,
    required this.onEdit,
  }) : super(key: key);

  @override
  _MedicineItemState createState() => _MedicineItemState();
}

class _MedicineItemState extends State<MedicineItem> {
  // Use a local state for the temporary count change before saving/checkout
  late int _count;

  @override
  void initState() {
    super.initState();
    // Initialize local count from medicine quantity.
    // NOTE: This count is typically used for a cart/sales functionality, not stock editing.
    // Keeping it as per your original code.
    _count = 0; // Keeping initialCount as 0 for a fresh sales/cart count
  }

  void _increment() {
    setState(() {
      _count++;
      // Call the callback to update the Home screen's total item count if needed
      // (Assuming this widget is for sales/cart counting)
      widget.onCountUpdate(widget.medicine.id, _count);
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) {
        _count--;
        widget.onCountUpdate(widget.medicine.id, _count);
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Stock':
        return Colors.green;
      case 'Low Stock':
        return Colors.orange;
      case 'Out of Stock':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(widget.medicine.id),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.medicine.status,
                        style: TextStyle(
                          color: _getStatusColor(widget.medicine.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.medicine.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.medicine.details,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '₹ ${widget.medicine.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: AssetImage(widget.medicine.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Quantity: ${widget.medicine.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // --- Edit Button ---
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => widget.onEdit(widget.medicine.id),
                    ),
                    const Text('Edit'),
                    const SizedBox(width: 10),
                    // --- Delete Button ---
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () => widget.onDelete(widget.medicine.id),
                    ),
                    const Text('Delete'),
                  ],
                ),
                // --- Sales/Cart Counter ---
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: _decrement,
                    ),
                    Text(
                      _count.toString(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: _increment,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}