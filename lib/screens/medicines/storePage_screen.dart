import 'package:flutter/material.dart';
import 'package:urmedio/widgets/bottom_navbar.dart'; // Import your custom BottomNavBar widget

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  // Helper function to build a filter chip
  Widget _buildFilterChip(String label, [IconData? icon]) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        avatar: icon != null ? Icon(icon, size: 18) : null,
        label: Text(label),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }

  // Helper function to build an offer card with an image
  Widget _buildOfferCard(String text, String imagePath) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: [
              Shadow(
                blurRadius: 3.0,
                color: Colors.white,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build a medicine card
  Widget _buildMedicineCard(String name, String price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine Store',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search medicines or health products',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('Nearest Location', Icons.location_on),
                  _buildFilterChip('Price: Low to High'),
                  _buildFilterChip('Price: High to Low'),
                  _buildFilterChip('Top Rated'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildOfferCard(
                        '',
                        'assets/images/offmed.png',
                      ),
                      const SizedBox(height: 5),
                      const Text('Flat 20% Off'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      _buildOfferCard(
                        '',
                        'assets/images/offmed1.png',
                      ),
                      const SizedBox(height: 5),
                      const Text('Free Delivery'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Recommended Medicines',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.7,
              children: [
                _buildMedicineCard('Paracetamol', 'Rs. 150', 'assets/images/rmed.png'),
                _buildMedicineCard('Ibuprofen', 'Rs. 200', 'assets/images/rmed1.png'),
                _buildMedicineCard('Vitamin C', 'Rs. 180', 'assets/images/rmed2.png'),
                _buildMedicineCard('Aspirin', 'Rs. 140', 'assets/images/rmed3.png'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // This is where you call the new widget
    );
  }
}