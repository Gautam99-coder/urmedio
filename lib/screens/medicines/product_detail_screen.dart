import 'package:flutter/material.dart';
import 'package:urmedio/theme/colors.dart';
import 'package:urmedio/widgets/bottom_navbar.dart'; // Import the custom BottomNavBar widget

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  /// Builds the main product image container
  Widget _buildImageCard() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDEEE5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset('assets/images/bigmed1.png', fit: BoxFit.contain),
      ),
    );
  }

  /// Builds the name and description section
  Widget _buildMedicineInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aspirin 500mg',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Aspirin is a common pain reliever and fever reducer. It\'s also used to prevent blood clots, reducing the risk of heart attacks and strokes.',
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
        ),
      ],
    );
  }

  /// Builds the entire rating section with score and progress bars
  Widget _buildRatingSection() {
    return Row(
      children: [
        // Left side: Overall Score
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '4.5',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star_half, color: Colors.amber),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              '125 reviews',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 24),
        // Right side: Rating bars
        Expanded(
          child: Column(
            children: [
              _buildRatingBar('5', 0.40, '40%'),
              _buildRatingBar('4', 0.30, '30%'),
              _buildRatingBar('3', 0.15, '15%'),
              _buildRatingBar('2', 0.10, '10%'),
              _buildRatingBar('1', 0.05, '5%'),
            ],
          ),
        ),
      ],
    );
  }

  /// Helper for a single rating progress bar row
  Widget _buildRatingBar(String label, double value, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.grey, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 21, 62, 95)),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 35,
            child: Text(
              percentage,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the price display
  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Price',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          'Rs 259',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// Builds the list of nearby pharmacies
  Widget _buildNearbyPharmacies(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nearby Pharmacies',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildPharmacyTile(
          'Gautam Pharmacy',
          '5.2 miles away',
          'assets/images/banner1.png',
          context,
        ),
        const SizedBox(height: 12),
        _buildPharmacyTile(
          'Sonali Pharmacy',
          '5.2 miles away',
          'assets/images/banner2.png',
          context,
        ),
      ],
    );
  }

  /// Helper for a single pharmacy list item
  Widget _buildPharmacyTile(String name, String distance, String imagePath, BuildContext context) {
    return Row(
      children: [
        Image.asset(imagePath, width: 50, height: 50),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(distance, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/locationSrc');
          },
          child: const Icon(Icons.location_on_outlined, color: Colors.grey),
        ),
      ],
    );
  }

  /// Builds the action buttons (Add to Cart and Buy Now)
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cartPage');
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: const Icon(Icons.add_shopping_cart_outlined,
              color: AppColors.primaryButton),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/checkoutPage");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButton,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text('Buy Now'),
          ),
        ),
      ],
    );
  }

  /// Builds the horizontal list of similar medicines
  Widget _buildSimilarMedicines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Similar Medicines',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildSimilarMedicineCard(
                'Strong Pain Relief',
                '200mg | 10 tablets',
                'assets/images/med1.png',
              ),
              _buildSimilarMedicineCard(
                'Pain Relief Tablets',
                '100mg | 20 tablets',
                'assets/images/midmed2.png',
              ),
              _buildSimilarMedicineCard(
                'Aspirin 50mg',
                '50mg | 30 tablets',
                'assets/images/midmed1.png',
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Helper for a single "similar medicine" card
  Widget _buildSimilarMedicineCard(
      String name, String details, String imagePath) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF9E3E3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: Image.asset(imagePath, height: 100)),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(details, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Medicine Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageCard(),
              const SizedBox(height: 24),
              _buildMedicineInfo(),
              const SizedBox(height: 24),
              _buildRatingSection(),
              const SizedBox(height: 24),
              _buildPriceSection(),
              const SizedBox(height: 24),
              _buildNearbyPharmacies(context),
              const SizedBox(height: 24),
              _buildActionButtons(context),
              const SizedBox(height: 32),
              _buildSimilarMedicines(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}