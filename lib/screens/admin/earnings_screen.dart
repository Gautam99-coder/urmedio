// lib/earnings_screen.dart

import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Light grey-blue background
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Earnings',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Profile Section ---
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/images/avatar.jpeg'), // Make sure to add this asset
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Dr. Ram',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: 12345678',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- Overall Stats Section ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('Rs 1,2340', 'Total\nEarnings', isExpanded: true),
                  _buildStatCard('123', 'Orders\nDelivered', isExpanded: true),
                  _buildStatCard('4.9', 'Average\nRating', isExpanded: true),
                ],
              ),
              const SizedBox(height: 32),

              // --- This Week Section ---
              const Text(
                'This Week',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildLargeStatCard('Total Earnings', 'Rs 5400'),
                  const SizedBox(width: 16),
                  _buildLargeStatCard('Orders Delivered', '12'),
                ],
              ),
              const SizedBox(height: 32),

              // --- Recent Earnings Section ---
              const Text(
                'Recent Earnings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRecentEarningItem('12345678', '129.34'),
              const Divider(),
              _buildRecentEarningItem('12345679', '120.34'),
              const Divider(),
              _buildRecentEarningItem('12345680', '145.34'),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the top three stat cards
  Widget _buildStatCard(String value, String label, {bool isExpanded = false}) {
    final card = Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.3
            ),
          ),
        ],
      ),
    );

    return isExpanded ? Expanded(child: card) : card;
  }

  // Helper widget for the two "This Week" cards
  Widget _buildLargeStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for each item in the "Recent Earnings" list
  Widget _buildRecentEarningItem(String orderId, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Completed',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                'Order ID: $orderId',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          Text(
            'Rs $amount',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32), // A nice green color for earnings
            ),
          ),
        ],
      ),
    );
  }
}