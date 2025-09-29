import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:urmedio/theme/colors.dart';

// --- Data Model for Medicine ---
class Medicine {
  final String name;
  final String type;
  final String imagePath;
  final Color backgroundColor;

  Medicine({
    required this.name,
    required this.type,
    required this.imagePath,
    required this.backgroundColor,
  });
}

// --- Home Screen Widget ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<Medicine> medicines = [
    Medicine(
        name: 'Paracetamol',
        type: 'Pain Relief',
        imagePath: 'assets/images/med1.png',
        backgroundColor: const Color(0xFFE5F0E5)),
    Medicine(
        name: 'Cetirizine',
        type: 'Antihistamine',
        imagePath: 'assets/images/med2.png',
        backgroundColor: const Color(0xFFFFF2E8)),
    Medicine(
        name: 'Ibuprofen',
        type: 'Painkiller',
        imagePath: 'assets/images/med3.png',
        backgroundColor: const Color(0xFFFFF2E8)),
    Medicine(
        name: 'Amoxicillin',
        type: 'Antibiotic',
        imagePath: 'assets/images/med1.png',
        backgroundColor: const Color(0xFFE5F0E5)),
    Medicine(
        name: 'Omeprazole',
        type: 'Acidity Relief',
        imagePath: 'assets/images/med2.png',
        backgroundColor: const Color(0xFFE5F0E5)),
  ];

  final List<String> bannerImagePaths = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  // --- MODIFIED METHOD ---
  // The navigation logic is now handled here.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the tapped item's index
    switch (index) {
      case 0:
        // Already on home, do nothing or refresh
        break;
      case 1:
        Navigator.pushNamed(context, '/storePage');
        break;
      case 2:
        // Navigate to the product page when cart is tapped
        Navigator.pushNamed(context, '/cartPage');
        break;
      case 3:
        Navigator.pushNamed(context, '/profilePage');
        break;
    }
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
            const Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:AppColors.primaryButton,
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
      itemCount: medicines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return MedicineCard(medicine: medicines[index]);
      },
    );
  }

  // --- UPDATED WIDGET ---
  // Uses `icon` for the default state and `activeIcon` for the selected state.
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
      selectedItemColor: AppColors.primaryButton,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}

// --- Medicine Card Widget (Unchanged) ---
class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    // This InkWell makes the card tappable
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.pushNamed(context, '/productPage');
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