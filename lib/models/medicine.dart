import 'package:flutter/material.dart';

class Medicine {
  final String name;
  final String type;
  final String imagePath;
  final Color backgroundColor;
  final String description;
  final double price;
  final String bigImagePath;

  Medicine({
    required this.name,
    required this.type,
    required this.imagePath,
    required this.backgroundColor,
    required this.description,
    required this.price,
    required this.bigImagePath,
  });
}