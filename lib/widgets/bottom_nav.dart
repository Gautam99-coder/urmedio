import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color textColor; // <-- ADDED: To accept a color

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textColor = Colors.black, // <-- ADDED: Default to black
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        // Style for the actual text the user types
        style: TextStyle(color: textColor), // <-- MODIFIED
        decoration: InputDecoration(
          labelText: label,
          // Style for the label text
          labelStyle: TextStyle(color: textColor), // <-- MODIFIED
          // The icon
          prefixIcon: Icon(icon, color: textColor), // <-- MODIFIED
          
          // Background and border styles for contrast
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: textColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}