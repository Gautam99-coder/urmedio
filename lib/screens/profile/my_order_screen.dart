import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // The actions list with the filter button has been removed
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search orders',
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
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _OrderItem(
                  imagePath: 'assets/images/ord1.png',
                  status: 'Order Received',
                  date: '21 March 2025',
                  onTap: () {
                    Navigator.pushNamed(context, '/ordreciv');
                  },
                ),
                _OrderItem(
                  imagePath: 'assets/images/ord2.png',
                  status: 'Order Cancelled',
                  date: '21 March 2025',
                  onTap: () {
                    Navigator.pushNamed(context, '/ordreciv');
                  },
                ),
                _OrderItem(
                  imagePath: 'assets/images/ord3.png',
                  status: 'Order Delivered',
                  date: '21 March 2025',
                  onTap: () {
                    Navigator.pushNamed(context, '/ordreciv');
                  },
                ),
                _OrderItem(
                  imagePath: 'assets/images/ord4.png',
                  status: 'Order Received',
                  date: '21 March 2025',
                  onTap: () {
                    Navigator.pushNamed(context, '/ordreciv');
                  },
                ),
                _OrderItem(
                  imagePath: 'assets/images/ord5.png',
                  status: 'Order Cancelled',
                  date: '21 March 2025',
                  onTap: () {
                    Navigator.pushNamed(context, '/ordreciv');
                  },
                ),
                _OrderItem(
                  imagePath: 'assets/images/ord6.png',
                  status: 'Order Delivered',
                  date: '21 March 2025',
                  onTap: () {
                    Navigator.pushNamed(context, '/ordreciv');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom widget to represent a single order item in the list.
class _OrderItem extends StatelessWidget {
  final String imagePath;
  final String status;
  final String date;
  final VoidCallback onTap;

  const _OrderItem({
    required this.imagePath,
    required this.status,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
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
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}