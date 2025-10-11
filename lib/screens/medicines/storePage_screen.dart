import 'package:flutter/material.dart';
import 'package:urmedio/theme/colors.dart';
import 'package:urmedio/widgets/bottom_navbar.dart'; // Import your custom BottomNavBar widget
// You MUST ensure these two imports are correct for the code to run:
//import '../home/medicine_data.dart'; // Contains Medicine class and allMedicines list
import 'package:urmedio/widgets/medicine_card.dart'; // Assuming this defines the Medicine class if not in medicine_data.dart

// Define the available sorting types
enum SortType {
  none,
  priceLowToHigh,
  priceHighToLow,
  nearestLocation,
  topRated
}

// --- Custom Medicine Card for the Store Screen Grid (Kept as StatelessWidget) ---
class StoreMedicineCard extends StatelessWidget {
  final Medicine medicine;

  const StoreMedicineCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    // The InkWell makes the card tappable for navigation
    return InkWell(
      onTap: () {
        // Navigate to the product detail page, passing the specific medicine object
        Navigator.pushNamed(
          context,
          '/productPage',
          arguments: medicine,
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
              // The image area uses the medicine's image and background color
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  // Using medicine's color with less opacity for the background
                  color: medicine.backgroundColor.withOpacity(0.5), 
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      medicine.imagePath, // Use the small product image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name, // Dynamic name
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rs. ${medicine.price.toStringAsFixed(2)}', // Dynamic price
                    style: const TextStyle(
                      color: AppColors.primaryButton, // Adjusted to match your primary blue
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- StoreScreen Widget (Converted to StatefulWidget) ---
class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // Master list of all available medicines (for filtering)
  final List<Medicine> _masterMedicines = allMedicines.toList();
  // List currently displayed on the screen (filtered and sorted)
  List<Medicine> _recommendedMedicines = [];
  
  // State variables for filtering and sorting
  String _searchQuery = '';
  SortType _currentSort = SortType.none;

  @override
  void initState() {
    super.initState();
    // Initialize with the default view (first 4 items)
    _filterAndSortMedicines();
  }

  // --- Core Filtering and Sorting Logic ---
  void _filterAndSortMedicines() {
    List<Medicine> filteredList = _masterMedicines;

    // 1. Apply Search Filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filteredList = filteredList.where((med) {
        return med.name.toLowerCase().contains(query) ||
              med.type.toLowerCase().contains(query);
      }).toList();
    } else {
      // If no search query, default to showing the first 4 items initially
      filteredList = filteredList.take(4).toList();
    }

    // 2. Apply Sorting
    switch (_currentSort) {
      case SortType.priceLowToHigh:
        filteredList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortType.priceHighToLow:
        filteredList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortType.nearestLocation:
        // Future logic for nearest location sorting goes here
        break;
      case SortType.topRated:
        // Future logic for rating sorting goes here
        break;
      case SortType.none:
        // Keep the list as is (either filtered by search or the top 4 default)
        break;
    }

    setState(() {
      _recommendedMedicines = filteredList;
    });
  }

  // --- Sorting Handler ---
  void _sortMedicines(SortType type) {
    // Determine the new sort type (toggle logic)
    SortType newSortType = (_currentSort == type) ? SortType.none : type;

    setState(() {
      _currentSort = newSortType;
      // Re-run the filter and sort logic
      _filterAndSortMedicines();
    });
  }

  // --- Search Handler ---
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _currentSort = SortType.none; // Reset sort when searching
      _filterAndSortMedicines();
    });
  }

  // Helper function to build a filter chip (UI unchanged, logic linked to state)
  Widget _buildFilterChip(String label, SortType type, [IconData? icon]) {
    final isSelected = _currentSort == type;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip( // Use ActionChip for tap
        avatar: icon != null ? Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.black87) : null,
        label: Text(label),
        onPressed: () => _sortMedicines(type),
        backgroundColor: isSelected ? const Color.fromARGB(255, 22, 64, 99) : Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isSelected ? BorderSide.none : BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  // Helper function to build an offer card with an image (UI unchanged)
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Added back button to AppBar for better navigation flow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
            // 🚀 KEY CHANGE: Add onChanged handler to the TextField
            TextField(
              onChanged: _onSearchChanged,
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
                  _buildFilterChip('Nearest Location', SortType.nearestLocation, Icons.location_on),
                  _buildFilterChip('Price: Low to High', SortType.priceLowToHigh),
                  _buildFilterChip('Price: High to Low', SortType.priceHighToLow),
                  _buildFilterChip('Top Rated', SortType.topRated),
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
            Text(
              _searchQuery.isNotEmpty 
                  ? 'Search Results (${_recommendedMedicines.length})' 
                  : 'Recommended Medicines',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // GridView dynamically renders the filtered/sorted list
            GridView.builder(
              itemCount: _recommendedMedicines.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return StoreMedicineCard(medicine: _recommendedMedicines[index]);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}