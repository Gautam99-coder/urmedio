import 'package:flutter/material.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart'; // Import your existing bottom navigation bar file

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              onPressed: () {},
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
              const Text(
                'Painkillers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    MedicineCard(
                      title: 'Ibuprofen',
                      subtitle: '200mg, Generic',
                      color: Color(0xFFF0F5EE),
                      imagePath: 'assets/images/imed1.png',
                    ),
                    MedicineCard(
                      title: 'Acetaminophen',
                      subtitle: '500mg, Tylenol',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed2.png',
                    ),
                    MedicineCard(
                      title: 'Naproxen',
                      subtitle: '250mg, Naprosyn',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed7.png',
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Antibiotics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    MedicineCard(
                      title: 'Amoxicillin',
                      subtitle: '500mg, Amoxil',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed4.png',
                    ),
                    MedicineCard(
                      title: 'Azithromycin',
                      subtitle: '250mg, Zithromax',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed5.png',
                    ),
                    MedicineCard(
                      title: 'Ciprofloxacin',
                      subtitle: '500mg, Cipro',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed2.png',
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Vitamins',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    MedicineCard(
                      title: 'Vitamin D',
                      subtitle: '1000IU, D-Vite',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed1.png',
                    ),
                    MedicineCard(
                      title: 'Vitamin C',
                      subtitle: '500mg, C-Plus',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed4.png',
                    ),
                    MedicineCard(
                      title: 'Multivitamin',
                      subtitle: 'Daily, Multivitamin',
                      color: Color(0xFFF9E8DB),
                      imagePath: 'assets/images/imed7.png',
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PBottomNavBar(
        selectedIndex: 0,
        onItemTapped: (int index) {},
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
          mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
          children: [
            Center( // Center the image horizontally
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
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