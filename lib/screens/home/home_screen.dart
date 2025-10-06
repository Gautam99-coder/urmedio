import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// Note: You must ensure 'Medicine' and 'allMedicines' are available 
// either by a correct import or by defining them here.
// I'm assuming 'allMedicines' is available globally/from a proper import path.
import 'package:urmedio/widgets/medicine_card.dart'; // Assuming this imports the Medicine class
//import '../home/medicine_data.dart'; // **Crucial: Assuming this path contains 'allMedicines' list**

// --- Home Screen Widget (Modified) ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController(); // Corrected class name

  // State variable to hold the search query
  String _searchQuery = ''; 

  // Master list of all medicines (unchanged)
  final List<Medicine> _masterMedicines = allMedicines; 

  // Computed property to get the list to display (filtered)
  List<Medicine> get _filteredMedicines {
    if (_searchQuery.isEmpty) {
      // If search is empty, show the default list
      return _masterMedicines;
    }
    
    // Filter by medicine name or type
    final query = _searchQuery.toLowerCase();
    return _masterMedicines.where((med) {
      return med.name.toLowerCase().contains(query) || 
             med.type.toLowerCase().contains(query);
    }).toList();
  }

  final List<String> bannerImagePaths = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/storePage');
        break;
      case 2:
        Navigator.pushNamed(context, '/cartPage');
        break;
      case 3:
        Navigator.pushNamed(context, '/profilePage');
        break;
    }
  }

  // --- Search Handler ---
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      // Rebuilding the widget tree will automatically use the filtered list
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar.jpeg'),
        ),
      ),
      title: const Text(
        'Mr.RAM\n360020.Rajkot extension',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 142, 37, 29),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.call, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black54, size: 28),
          onPressed: () {
            Navigator.pushNamed(context, '/notificationsrc');
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildImageCarousel(),
            const SizedBox(height: 24),
            Text(
              _searchQuery.isNotEmpty ? 'Search Results (${_filteredMedicines.length})' : 'Quick Access',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildMedicineGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: _onSearchChanged, // 🚀 KEY CHANGE: Add search handler
      decoration: InputDecoration(
        hintText: 'Search Medicines',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildImageCarousel() {
    // Only show carousel if not actively searching
    if (_searchQuery.isNotEmpty) {
      return const SizedBox.shrink(); 
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: bannerImagePaths.length,
          carouselController: _carouselController,
          itemBuilder: (context, index, realIndex) {
            final imagePath = bannerImagePaths[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerImagePaths.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(_currentCarouselIndex == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMedicineGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // 🚀 KEY CHANGE: Use the filtered list here
      itemCount: _filteredMedicines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return MedicineCard(medicine: _filteredMedicines[index]);
      },
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_outlined),
          activeIcon: Icon(Icons.store),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 22, 50, 98),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}

// --- Medicine Card Widget (Unchanged and kept for completeness) ---
class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // --- KEY CHANGE: Pass the medicine object as an argument ---
        Navigator.pushNamed(
          context,
          '/productPage',
          arguments: medicine,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: medicine.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    medicine.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      medicine.type,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}