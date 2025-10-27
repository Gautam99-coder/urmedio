import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:urmedio/models/medicine_model.dart';
import 'package:urmedio/widgets/bottom_navbar.dart';

class ProductDetailScreen extends StatelessWidget {
  final Medicine medicine;

  const ProductDetailScreen({super.key, required this.medicine});

  Widget _buildImageCard() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: medicine.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CachedNetworkImage(
          imageUrl: medicine.bigImageUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildMedicineInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          medicine.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          medicine.description,
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
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
            const Text('125 reviews', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(width: 24),
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
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 21, 62, 95)),
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

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price', style: TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(height: 4),
        Text('Rs ${medicine.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildNearbyPharmacies(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nearby Pharmacies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildPharmacyTile('Gautam Pharmacy', '5.2 miles away', 'assets/images/banner1.png', context),
        const SizedBox(height: 12),
        _buildPharmacyTile('Sonali Pharmacy', '5.2 miles away', 'assets/images/banner2.png', context),
      ],
    );
  }

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
          onTap: () => Navigator.pushNamed(context, '/locationSrc'),
          child: const Icon(Icons.location_on_outlined, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, '/cartPage'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: const Icon(Icons.add_shopping_cart_outlined, color: Color.fromARGB(255, 25, 59, 88)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/checkoutPage'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 22, 64, 99),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text('Buy Now'),
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarMedicines(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Similar Medicines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('medicines')
                .where('type', isEqualTo: medicine.type)
                .where('name', isNotEqualTo: medicine.name)
                .limit(4)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No similar medicines found.'));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final simMedicine = Medicine.fromFirestore(snapshot.data!.docs[index]);
                  return _buildSimilarMedicineCard(simMedicine, context);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarMedicineCard(Medicine similarMedicine, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/productPage', arguments: similarMedicine);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: similarMedicine.backgroundColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: similarMedicine.imageUrl,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(similarMedicine.name, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(similarMedicine.type, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: () => Navigator.of(context).pop()),
        title: Text(medicine.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            _buildSimilarMedicines(context),
            const SizedBox(height: 20),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
