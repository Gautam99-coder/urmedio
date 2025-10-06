import 'package:flutter/material.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart'; // Make sure this path is correct

class PhomeScreen extends StatefulWidget {
  const PhomeScreen({Key? key}) : super(key: key);

  @override
  State<PhomeScreen> createState() => _PhomeScreenState();
}

class _PhomeScreenState extends State<PhomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            backgroundImage: AssetImage('assets/images/profile1.png'),
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
      // This line triggers the navigation to the '/settings' route
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
            // Stock Summary Cards
            Row(
              children: [
                _buildStockCard('In Stock', 120, Colors.blue),
                const SizedBox(width: 10),
                _buildStockCard('Low Stock', 30, Colors.blue.shade300),
                const SizedBox(width: 10),
                _buildStockCard('Out of Stock', 10, Colors.blue.shade300),
              ],
            ),
            const SizedBox(height: 20),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search medicines...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            // Inventory Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Inventory',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
            // Analytics Button
            
            // Medicine List
            const MedicineItem(
              status: 'In Stock',
              medicineName: 'Paracetamol',
              details: 'Acetaminophen • 500mg • GSK',
              price: 150,
              quantity: 100,
              initialCount: 7,
              imagePath: 'assets/images/pmed.png',
            ),
            const SizedBox(height: 10),
            const MedicineItem(
              status: 'Low Stock',
              medicineName: 'Ibuprofen',
              details: 'Ibuprofen • 200mg • Pfizer',
              price: 120,
              quantity: 20,
              initialCount: 2,
              imagePath: 'assets/images/pmed1.png', 
            ),
            const SizedBox(height: 10),
            const MedicineItem(
              status: 'Out of Stock',
              medicineName: 'Amoxicillin',
              details: 'Amoxicillin • 250mg • Cipla',
              price: 80,
              quantity: 0,
              initialCount: 0,
              imagePath: 'assets/images/pmed2.png',
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

  Widget _buildStockCard(String title, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
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
    );
  }
}

class MedicineItem extends StatefulWidget {
  final String status;
  final String medicineName;
  final String details;
  final int price;
  final int quantity;
  final int initialCount;
  final String imagePath;

  const MedicineItem({
    Key? key,
    required this.status,
    required this.medicineName,
    required this.details,
    required this.price,
    required this.quantity,
    required this.initialCount,
    required this.imagePath,
  }) : super(key: key);

  @override
  _MedicineItemState createState() => _MedicineItemState();
}

class _MedicineItemState extends State<MedicineItem> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) {
        _count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.status,
                        style: TextStyle(
                          color: widget.status == 'In Stock'
                              ? Colors.green
                              : widget.status == 'Low Stock'
                                  ? Colors.orange
                                  : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.medicineName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.details,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '₹ ${widget.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Quantity: ${widget.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () {
                        Navigator.pushNamed(context, '/updatestock');
                      },
                    ),
                    const Text('Edit'),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () {},
                    ),
                    const Text('Delete'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: _decrement,
                    ),
                    Text(
                      _count.toString(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: _increment,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}