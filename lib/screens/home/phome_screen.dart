// phome_screen.dart

import 'package:flutter/material.dart';
import 'package:urmedio/models/medicine_data.dart';
import 'package:urmedio/widgets/medicine_item.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart';
// ... other imports ...

class PhomeScreen extends StatefulWidget {
  const PhomeScreen({Key? key}) : super(key: key);

  @override
  State<PhomeScreen> createState() => _PhomeScreenState();
}

class _PhomeScreenState extends State<PhomeScreen> {
  int _selectedIndex = 0;
  String _currentFilter = 'All'; // Filter state: 'All', 'In Stock', 'Low Stock', 'Out of Stock'
  String _searchQuery = ''; // Search state

  late MedicineDataService _service;

  @override
  void initState() {
    super.initState();
    _service = medicineDataService; // Get the global instance
    _service.addListener(_onMedicineDataChanged);
  }

  @override
  void dispose() {
    _service.removeListener(_onMedicineDataChanged);
    super.dispose();
  }

  void _onMedicineDataChanged() {
    // This forces a rebuild whenever the medicine list changes in the service
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate based on index (assuming 0 is Home, 1 is Inventory)
    if (index == 1) {
      Navigator.pushNamed(context, '/inventory');
    }
  }

  List<Medicine> get _filteredMedicines {
    List<Medicine> list = _service.medicines;

    // 1. Filter by Stock Status
    if (_currentFilter != 'All') {
      list = list.where((m) => m.status == _currentFilter).toList();
    }

    // 2. Filter by Search Query
    if (_searchQuery.isNotEmpty) {
      list = list.where((m) =>
          m.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          m.details.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return list;
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // --- Callbacks for MedicineItem ---
  void _onDeleteMedicine(String id) {
    _service.deleteMedicine(id);
    _showSnackbar('Medicine successfully deleted! 🗑️');
  }

  void _onEditMedicine(String id) {
    // Navigate to a dedicated update screen or use the AddMedicineScreen for editing
    Navigator.pushNamed(context, '/updatestock', arguments: id);
  }

  void _onCountUpdate(String id, int newCount) {
    // This logic is usually for sales/cart. For now, it just updates the internal state of MedicineItem.
    // If you need to update the actual stock, the user should use the 'Edit' button.
  }
  // -----------------------------------

  // 🚀 Helper to generate the correct display text
  String get _inventoryHeaderText {
    final count = _filteredMedicines.length;
    
    if (_currentFilter == 'All') {
      return 'Inventory (All | $count)';
    } else {
      // Shorter text when a filter is active to avoid overflow
      return '$_currentFilter | $count';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avater2.jpeg'),
          ),
        ),
        title: const Text(
          'MediCare Pharmacy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/settingScr');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Stock Summary Cards (Filters) ---
            Row(
              children: [
                _buildStockCard('In Stock', _service.inStockCount, 'In Stock', Colors.blue),
                const SizedBox(width: 10),
                _buildStockCard('Low Stock', _service.lowStockCount, 'Low Stock', Colors.blue.shade300!),
                const SizedBox(width: 10),
                _buildStockCard('Out of Stock', _service.outOfStockCount, 'Out of Stock', Colors.blue.shade300!),
              ],
            ),
            const SizedBox(height: 20),
            // --- Search Bar ---
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search medicines...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            // --- Inventory Section Header ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    // 🚀 USE THE SHORTER HEADER TEXT
                    _inventoryHeaderText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addMedicine');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    '+ Add Medicine',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // --- Medicine List ---
            ..._filteredMedicines.map((medicine) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MedicineItem(
                    medicine: medicine,
                    onDelete: _onDeleteMedicine,
                    onEdit: _onEditMedicine,
                    onCountUpdate: _onCountUpdate,
                  ),
                )).toList(),

            if (_filteredMedicines.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: Text(
                    _searchQuery.isNotEmpty
                        ? 'No medicine found for "$_searchQuery".'
                        : 'No medicines match the selected filter.',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: PBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // --- _buildStockCard method ---
  Widget _buildStockCard(String title, int count, String filterValue, Color originalColor) {
    // Check if the current filter is active. We treat 'In Stock' as the 'All' state 
    // when displaying the count for the first card to mimic the original look.
    final isActiveFilter = _currentFilter == filterValue;
    
    // Determine the background color
    Color cardColor;
    if (_currentFilter == 'All') {
        // If 'All' is selected, use the original colors.
        cardColor = originalColor;
    } else {
        // If a specific filter is selected:
        if (isActiveFilter) {
            // Use a slightly darker shade for the active card.
            cardColor = originalColor == Colors.blue 
                ? const Color(0xFF0D47A1) // Darker Blue for active 'In Stock'
                : originalColor.withOpacity(1.0); // Maintain original shade for Low/Out
        } else {
            // Fade the inactive cards (light grey overlay)
            cardColor = originalColor.withOpacity(0.4); 
        }
    }

    // Determine the border for the active filter
    final borderStyle = isActiveFilter
        ? Border.all(color: Colors.white, width: 3) // Use a white border for contrast
        : null;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Toggle logic: tapping the active filter returns to 'All'
            _currentFilter = isActiveFilter ? 'All' : filterValue;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
            border: borderStyle,
            boxShadow: isActiveFilter 
                ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}