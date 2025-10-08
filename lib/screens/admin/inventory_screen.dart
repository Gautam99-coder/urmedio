// inventory_screen.dart

import 'package:flutter/material.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart';
import 'package:urmedio/models/medicine_data.dart'; // Import the service

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late MedicineDataService _service;

  @override
  void initState() {
    super.initState();
    _service = medicineDataService;
    _service.addListener(_onMedicineDataChanged);
  }

  @override
  void dispose() {
    _service.removeListener(_onMedicineDataChanged);
    super.dispose();
  }

  void _onMedicineDataChanged() {
    // Rebuild the screen when the medicine data changes
    setState(() {});
  }

  // Helper function to group medicines by category
  Map<String, List<Medicine>> _groupMedicinesByCategory() {
    final Map<String, List<Medicine>> grouped = {};
    for (var medicine in _service.medicines) {
      if (!grouped.containsKey(medicine.category)) {
        grouped[medicine.category] = [];
      }
      grouped[medicine.category]!.add(medicine);
    }
    return grouped;
  }

  // Dummy colors for MedicineCard backgrounds
  static const List<Color> _cardColors = [
    Color(0xFFF0F5EE), // Light Green
    Color(0xFFF9E8DB), // Light Orange
    Color(0xFFE3F2FD), // Light Blue
    Color(0xFFF3E5F5), // Light Purple
  ];

  Color _getColorForIndex(int index) {
    return _cardColors[index % _cardColors.length];
  }

  @override
  Widget build(BuildContext context) {
    final groupedMedicines = _groupMedicinesByCategory();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'All Medicines',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addMedicine');
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFE3F2FD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Add Medicine',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (groupedMedicines.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text(
                      'No medicines in inventory. Tap "Add Medicine" to start.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),

              ...groupedMedicines.entries.toList().asMap().entries.map((entry) {
                int categoryIndex = entry.key;
                String category = entry.value.key;
                List<Medicine> medicines = entry.value.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: medicines.length,
                        itemBuilder: (context, index) {
                          final medicine = medicines[index];
                          return MedicineCard(
                            title: medicine.name,
                            subtitle: medicine.details,
                            color: _getColorForIndex(categoryIndex + index), // Vary colors
                            imagePath: medicine.imagePath,
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement navigation to a screen showing all medicines in this category
                      },
                      child: const Text('View All'),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      // NOTE: You'll need to define selectedIndex for the InventoryScreen in your main file
      // I've hardcoded a placeholder for now.
      bottomNavigationBar: PBottomNavBar(
        selectedIndex: 1, // Assuming Inventory is the second item (index 1)
        onItemTapped: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home'); // Navigate back to home
          }
          // The other navigation logic is usually handled in the main routes setup.
        },
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String imagePath;

  const MedicineCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  width: 80,
                  height: 80,
                  child: Icon(Icons.medication_liquid_outlined, size: 50, color: Colors.grey),
                ),
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}