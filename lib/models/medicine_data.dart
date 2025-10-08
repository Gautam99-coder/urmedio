// lib/models/medicine_data.dart

import 'package:flutter/material.dart';

class Medicine {
  final String id; // Unique ID for keying/deletion
  String name;
  String details;
  double price;
  int quantity;
  String expiryDate;
  String imagePath;
  String category; // New field for category/grouping

  Medicine({
    required this.id,
    required this.name,
    required this.details,
    required this.price,
    required this.quantity,
    required this.expiryDate,
    required this.imagePath,
    this.category = 'Other', // Default category
  });

  String get status {
    if (quantity <= 0) return 'Out of Stock';
    if (quantity < 20) return 'Low Stock'; // Arbitrary threshold
    return 'In Stock';
  }

  // Helper method to update a medicine
  Medicine copyWith({
    String? id,
    String? name,
    String? details,
    double? price,
    int? quantity,
    String? expiryDate,
    String? imagePath,
    String? category,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      details: details ?? this.details,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      expiryDate: expiryDate ?? this.expiryDate,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
    );
  }
}

// A simple service class to manage the state of medicines
// In a real app, you'd use a state management solution or a database
class MedicineDataService with ChangeNotifier {
  // Initial sample data
  List<Medicine> _medicines = [
    Medicine(
      id: '1',
      name: 'Paracetamol',
      details: 'Acetaminophen • 500mg • GSK',
      price: 150,
      quantity: 100,
      expiryDate: '12/2026',
      imagePath: 'assets/images/pmed.png',
      category: 'Painkillers',
    ),
    Medicine(
      id: '2',
      name: 'Ibuprofen',
      details: 'Ibuprofen • 200mg • Pfizer',
      price: 120,
      quantity: 20,
      expiryDate: '01/2025',
      imagePath: 'assets/images/pmed1.png',
      category: 'Painkillers',
    ),
    Medicine(
      id: '3',
      name: 'Amoxicillin',
      details: 'Amoxicillin • 250mg • Cipla',
      price: 80,
      quantity: 0,
      expiryDate: '05/2024',
      imagePath: 'assets/images/pmed2.png',
      category: 'Antibiotics',
    ),
  ];

  List<Medicine> get medicines => _medicines;

  void addMedicine(Medicine medicine) {
    _medicines.add(medicine);
    notifyListeners();
  }

  void deleteMedicine(String id) {
    _medicines.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  void updateMedicineQuantity(String id, int newQuantity) {
    final index = _medicines.indexWhere((m) => m.id == id);
    if (index != -1) {
      _medicines[index].quantity = newQuantity;
      // Also update the details field to reflect the quantity for the item card in home screen
      // For simplicity, we'll just force a refresh
      notifyListeners();
    }
  }

  // Helper method for home screen's stock counts
  int get inStockCount => _medicines.where((m) => m.status == 'In Stock').length;
  int get lowStockCount => _medicines.where((m) => m.status == 'Low Stock').length;
  int get outOfStockCount => _medicines.where((m) => m.status == 'Out of Stock').length;
}

// Global instance (simple state management)
final medicineDataService = MedicineDataService();