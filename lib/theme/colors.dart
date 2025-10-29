// lib/utils/app_colors.dart
import 'package:flutter/material.dart';

/// A centralized class for managing all app colors.
/// Use [AppColors] to maintain color consistency across the app.
class AppColors {
  // ------------------------------
  // 🎨 Brand Colors
  // ------------------------------
  static const Color primary = Color(0xFF13284D); // Deep Navy Blue
  static const Color secondary = Color(0xFF0C3455); // Muted Blue
  static const Color accent = Color(0xFF2080CF); // Sky Blue

  // ------------------------------
  // 🌗 Neutral Colors
  // ------------------------------
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF6F6F6); // Light gray background
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF757575); // Medium gray
  static const Color divider = Color(0xFFE0E0E0);

  // ------------------------------
  // ✅ Status Colors
  // ------------------------------
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFFC107); // Amber
  static const Color error = Color(0xFFF44336);   // Red
  static const Color info = Color(0xFF2196F3);    // Blue

  // ------------------------------
  // 🔘 Button Colors
  // ------------------------------
  static const Color primaryButton = primary;
  static const Color secondaryButton = secondary;
  static const Color disabledButton = Color(0xFFBDBDBD);

  // ------------------------------
  // 🌙 Dark Mode Support
  // ------------------------------
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFBDBDBD);

  // ------------------------------
  // 🧩 Utility Colors
  // ------------------------------
  static const Color shadow = Colors.black26;
  static const Color border = Color(0xFFDDDDDD);

// Example usage:
// Container(color: AppColors.primary)
}
