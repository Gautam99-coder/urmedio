import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


// --- Main App Entry Point ---
void main() {
  runApp(const PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

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
  // ✅ FIX 1: Corrected controller class name
  final CarouselSliderController _carouselController = CarouselSliderController();

  // ✅ FIX 2: Standardized all medicine data to use 'imagePath' with the correct 'lib/' prefix
  final List<Medicine> medicines = [
    Medicine(
        name: 'Paracetamol',
        type: 'Pain Relief',
        imagePath: 'assets/images/med1.png',
        backgroundColor: const Color(0xFFE5F0E5)),
    Medicine(
        name: 'Cetirizine',
        type: 'Antihistamine',
        imagePath: 'lib/assets/images/cetirizine.png',
        backgroundColor: const Color(0xFFFFF2E8)),
    Medicine(
        name: 'Ibuprofen',
        type: 'Painkiller',
        imagePath: 'lib/assets/images/ibuprofen.png',
        backgroundColor: const Color(0xFFFFF2E8)),
    Medicine(
        name: 'Amoxicillin',
        type: 'Antibiotic',
        imagePath: 'lib/assets/images/amoxicillin.png',
        backgroundColor: const Color(0xFFE5F0E5)),
    Medicine(
        name: 'Omeprazole',
        type: 'Acidity Relief',
        imagePath: 'lib/assets/images/omeprazole.png',
        backgroundColor: const Color(0xFFE5F0E5)),
  ];
  
  // ✅ FIX 3: Corrected all banner paths to include 'lib/' prefix
  final List<String> bannerImagePaths = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'lib/assets/images/banner3.png',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
          // ✅ FIX 4: Corrected avatar image path
          backgroundImage: AssetImage('lib/assets/images/avatar.png'),
        ),
      ),
      title: const Text(
        '360020.Rajkot extension',
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
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.call, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black54, size: 28),
          onPressed: () {},
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
            return GestureDetector(
              onTap: () {
                print('Tapped on banner image: $imagePath');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on banner ${index + 1}')),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
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

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}