// lib/models/medicine_model.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  final String id;
  final String name;
  final String type;
  final String description;
  final double price;
  final String imageUrl;      // For card/list view
  final String bigImageUrl;   // For detail page
  final Color backgroundColor;
  // You can add rating fields here later

  Medicine({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.bigImageUrl,
    required this.backgroundColor,
  });

  // Helper function to parse hex string to Color
  static Color _colorFromHex(String hexColor) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      return Colors.grey[200]!; // Default color on error
    }
  }

  // Factory constructor to create a Medicine from a Firestore document
  factory Medicine.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return Medicine(
      id: doc.id,
      name: data['name'] ?? 'No Name',
      type: data['type'] ?? 'No Type',
      description: data['description'] ?? 'No Description',
      // Ensure 'price' is stored as a number (double or int) in Firestore
      price: (data['price'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? '', 
      // Use the same image if bigImageUrl isn't specified
      bigImageUrl: data['bigImageUrl'] ?? data['imageUrl'] ?? '',
      backgroundColor: _colorFromHex(data['backgroundColor'] ?? '0xFFF5F5F5'),
    );
  }
}