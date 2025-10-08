import 'package:flutter/material.dart';

// --- Data Model for Medicine ---
// This is the same class you defined in your HomeScreen for consistency.
class Medicine {
  final String name;
  final String type;
  final String imagePath;
  final Color backgroundColor;
  final String description;
  final double price;
  final String bigImagePath; // Path for the large image on the detail screen

  Medicine({
    required this.name,
    required this.type,
    required this.imagePath,
    required this.backgroundColor,
    required this.description,
    required this.price,
    required this.bigImagePath,
  });
}

// --- List of all Medicine Data ---
final List<Medicine> allMedicines = [
  Medicine(
    name: 'Paracetamol 500mg',
    type: 'Pain Relief',
    imagePath: 'assets/images/med1.png',
    backgroundColor: const Color(0xFFE5F0E5),
    description:
        'Paracetamol is a common pain reliever used to treat aches and pains, and reduce high temperature (fever). It is available in tablets, capsules, and liquid forms.',
    price: 99.50,
    bigImagePath: 'assets/images/med1.png',
  ),
  Medicine(
    name: 'Cetirizine 10mg',
    type: 'Antihistamine',
    imagePath: 'assets/images/med2.png',
    backgroundColor: const Color(0xFFFFF2E8),
    description:
        'Cetirizine is a non-drowsy antihistamine that is used to relieve the symptoms of hay fever and other allergies, such as sneezing, runny nose, and watery eyes.',
    price: 150.00,
    bigImagePath: 'assets/images/med2.png',
  ),

Medicine(
    name: 'Cetirizine 10mg',
    type: 'Antihistamine',
    imagePath: 'assets/images/avater2.jpeg',
    backgroundColor: const Color(0xFFFFF2E8),
    description:
        'Cetirizine is a non-drowsy antihistamine that is used to relieve the symptoms of hay fever and other allergies, such as sneezing, runny nose, and watery eyes.',
    price: 150.00,
    bigImagePath: 'assets/images/avater2.jpeg',
  ),

  Medicine(
    name: 'Ibuprofen 400mg',
    type: 'Painkiller',
    imagePath: 'assets/images/med3.png',
    backgroundColor: const Color(0xFFFFF2E8),
    description:
        'Ibuprofen is a non-steroidal anti-inflammatory drug (NSAID) used for pain, fever, and inflammation. It is commonly used for headaches, toothaches, and menstrual pain.',
    price: 185.00,
    bigImagePath: 'assets/images/med3.png',
  ),
  Medicine(
    name: 'Amoxicillin 250mg',
    type: 'Antibiotic',
    imagePath: 'assets/images/med1.png',
    backgroundColor: const Color(0xFFE5F0E5),
    description:
        'Amoxicillin is an antibiotic used to treat bacterial infections, such as chest infections (including pneumonia), dental abscesses, and urinary tract infections (UTIs).',
    price: 320.90,
    bigImagePath: 'assets/images/med1.png',
  ),
  Medicine(
    name: 'Omeprazole 20mg',
    type: 'Acidity Relief',
    imagePath: 'assets/images/med2.png',
    backgroundColor: const Color(0xFFE5F0E5),
    description:
        'Omeprazole is a proton pump inhibitor (PPI) used to treat indigestion, heartburn, acid reflux, and ulcers. It works by reducing the amount of acid your stomach makes.',
    price: 210.25,
    bigImagePath: 'assets/images/med2.png',
  ),
];