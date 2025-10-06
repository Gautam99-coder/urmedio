import 'package:flutter/material.dart';
import 'package:urmedio/widgets/pbottom_navbar.dart'; // Make sure this path is correct

// A simple model class for an Order item
class OrderItemData {
  final String patientName;
  final String medicineName;
  final String orderId;
  final String status;
  final Color statusColor;
  final String imagePath;

  OrderItemData({
    required this.patientName,
    required this.medicineName,
    required this.orderId,
    required this.status,
    required this.statusColor,
    required this.imagePath,
  });
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedIndex = 1;
  // 1. State variable for the selected filter (default is 'All Orders')
  String _selectedFilter = 'All Orders';
  final List<String> _filterOptions = [
    'All Orders',
    'Pending',
    'Delivered',
    'Shipped',
    'Cancelled'
  ];

  // Hardcoded list of all orders (from your original _buildOrderItem calls)
  final List<OrderItemData> _allOrders = [
    OrderItemData(
      patientName: 'Alisha Patel',
      medicineName: 'Paracetamol,Ethanol',
      orderId: '#12345',
      status: 'Pending',
      statusColor: Colors.red,
      imagePath: 'assets/images/p1.png',
    ),
    OrderItemData(
      patientName: 'Gautam Tharu',
      medicineName: 'Ibuprofen',
      orderId: '#67890',
      status: 'Delivered',
      statusColor: Colors.green,
      imagePath: 'assets/images/p2.png',
    ),
    OrderItemData(
      patientName: 'Black Widow',
      medicineName: 'Cetirizine',
      orderId: '#11223',
      status: 'Shipped',
      statusColor: Colors.blue,
      imagePath: 'assets/images/p3.png',
    ),
    OrderItemData(
      patientName: 'Super Nova',
      medicineName: 'Antacid',
      orderId: '#44556',
      status: 'Cancelled',
      statusColor: Colors.red,
      imagePath: 'assets/images/p4.png',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 2. Filter logic function
  List<OrderItemData> _getFilteredOrders() {
    if (_selectedFilter == 'All Orders') {
      return _allOrders;
    } else {
      return _allOrders
          .where((order) => order.status == _selectedFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of orders to display based on the current filter
    final filteredOrders = _getFilteredOrders();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 
        
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
                  count: _allOrders.length, // Dynamic total count
                  imagePath: 'assets/images/totalorder.jpg',
                ),
                const SizedBox(width: 10),
                _buildSummaryCard(
                  title: 'Pending Orders',
                  count: _allOrders.where((o) => o.status == 'Pending').length, // Dynamic pending count
                  imagePath: 'assets/images/panding1.png',
                ),
                const SizedBox(width: 10),
                _buildSummaryCard(
                  title: 'Delivered',
                  count: _allOrders.where((o) => o.status == 'Delivered').length, // Dynamic delivered count
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
            // *** Filter Dropdown Widget (Replaced the static Container) ***
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  icon: const Icon(Icons.arrow_drop_down),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  items: _filterOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedFilter = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // *** Orders List (Now built dynamically using map and spread operator) ***
            if (filteredOrders.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    'No orders match the current filter.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              ...filteredOrders.map((order) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: _buildOrderItem(
                    order.patientName,
                    order.medicineName,
                    order.orderId,
                    order.status,
                    order.statusColor,
                    order.imagePath,
                  ),
                );
              }).toList(),
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
              // You might want to adjust the height/fit of images here based on your actual assets
              Image.asset(
                imagePath,
                height: 50, // Reduced height for better card fit
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 5),
              Text(
                count.toString(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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