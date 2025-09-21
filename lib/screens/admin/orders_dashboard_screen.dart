import 'package:flutter/material.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart'; // Make sure this path is correct

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedIndex = 1; // Assuming 'Orders' is the second item (index 1)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add your navigation logic here based on the index
    // For example:
    // if (index == 0) {
    //   Navigator.pushReplacementNamed(context, '/home');
    // }
    // else if (index == 2) {
    //   Navigator.pushReplacementNamed(context, '/products');
    // }
    // else if (index == 3) {
    //   Navigator.pushReplacementNamed(context, '/profile');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Orders Summary Cards
            Row(
              children: [
                _buildSummaryCard(
                  title: 'Total Orders',
                  count: 120,
                  imagePath: 'assets/images/totalorder.jpg',
                ),
                const SizedBox(width: 10),
                _buildSummaryCard(
                  title: 'Pending Orders',
                  count: 30,
                  imagePath: 'assets/images/panding1.png',
                ),
                const SizedBox(width: 10),
                _buildSummaryCard(
                  title: 'Delivered',
                  count: 90,
                  imagePath: 'assets/images/delivered.png',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Orders section header
            const Text(
              'Orders',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Filter Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('All Orders', style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Orders List
            _buildOrderItem(
              'Alisha Patel',
              'Paracetamol,Ethanol',
              '#12345',
              'Pending',
              Colors.red,
              'assets/images/p1.png',
            ),
            const SizedBox(height: 10),
            _buildOrderItem(
              'Gautam Tharu',
              'Ibuprofen',
              '#67890',
              'Delivered',
              Colors.green,
              'assets/images/p2.png',
            ),
            const SizedBox(height: 10),
            _buildOrderItem(
              'Black Widow',
              'Cetirizine',
              '#11223',
              'Shipped',
              Colors.blue,
              'assets/images/p3.png',
            ),
            const SizedBox(height: 10),
            _buildOrderItem(
              'Super Nova',
              'Antacid',
              '#44556',
              'Cancelled',
              Colors.red,
              'assets/images/p4.png',
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

  Widget _buildSummaryCard({
    required String title,
    required int count,
    required String imagePath,
  }) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                count.toString(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(
    String patientName,
    String medicineName,
    String orderId,
    String status,
    Color statusColor,
    String imagePath,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient: $patientName',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(medicineName, style: const TextStyle(color: Colors.grey)),
                  Text('Order ID: $orderId',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}