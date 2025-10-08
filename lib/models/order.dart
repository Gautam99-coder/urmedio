import 'package:flutter/material.dart';

enum OrderStatus {
  received,
  shipped,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayTitle {
    switch (this) {
      case OrderStatus.received:
        return 'Order Received';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.delivered:
        return Colors.green[700]!;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.shipped:
        return Colors.orange[700]!;
      case OrderStatus.received:
      default:
        return const Color.fromARGB(255, 15, 61, 99);
    }
  }
}

class OrderItem {
  final String imagePath;
  final String name;
  final String description;
  final String details; // e.g., Quantity x Price

  OrderItem({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.details,
  });
}

class Order {
  final String id;
  final String date;
  final OrderStatus status;
  final String paymentMethod;
  final String totalAmount;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.paymentMethod,
    required this.totalAmount,
    required this.items,
  });
}

// Mock Data
List<Order> allOrders = [
  Order(
    id: 'URMED-1001',
    date: '2025-10-01',
    status: OrderStatus.delivered,
    paymentMethod: 'Credit Card',
    totalAmount: '\Rs 45.50',
    items: [
      OrderItem(
        imagePath: 'assets/images/ord1.png',
        name: 'Paracetamol Tablets',
        description: '500mg, Pack of 20',
        details: '2 x \Rs 10.00',
      ),
      OrderItem(
        imagePath: 'assets/images/ord2.png',
        name: 'Multi-Vitamin Syrup',
        description: '200ml bottle',
        details: '1 x \Rs 25.50',
      ),
    ],
  ),
  Order(
    id: 'URMED-1002',
    date: '2025-09-28',
    status: OrderStatus.shipped,
    paymentMethod: 'Cash on Delivery',
    totalAmount: '\RS 150.00',
    items: [
      OrderItem(
        imagePath: 'assets/images/ord3.png',
        name: 'Hand Sanitizer Gel',
        description: '50ml bottle',
        details: '3 x \Rs 50.00',
      ),
    ],
  ),
  Order(
    id: 'URMED-1003',
    date: '2025-09-25',
    status: OrderStatus.cancelled,
    paymentMethod: 'PayPal',
    totalAmount: '\Rs 80.99',
    items: [
      OrderItem(
        imagePath: 'assets/images/ord4.png',
        name: 'Inhaler Device',
        description: 'Aerosol, 100 doses',
        details: '1 x \Rs 200.99',
      ),
    ],
  ),
  Order(
    id: 'URMED-1004',
    date: '2025-10-06',
    status: OrderStatus.received,
    paymentMethod: 'Credit Card',
    totalAmount: '\Rs 102.99',
    items: [
      OrderItem(
        imagePath: 'assets/images/ord5.png',
        name: 'Band-Aids Pack',
        description: 'Assorted sizes, 50 count',
        details: '1 x \Rs 222.99',
      ),
    ],
  ),
];