import 'package:flutter/material.dart';
import 'package:urmedio/theme/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation based on the selected index
    if (index == 0) {
      Navigator.pushNamed(context, '/homePage');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/storePage');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/cartPage');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/profilePage');
    }
  }

  @override
  Widget build(BuildContext context) {
    // You'll need to get the current route to set the correct selected item.
    // This is a simple way to do it, but you could also pass an 'initialIndex'.
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/homePage') {
      _currentIndex = 0;
    } else if (currentRoute == '/storePage') {
      _currentIndex = 1;
    } else if (currentRoute == '/cartPage') {
      _currentIndex = 2;
    } else if (currentRoute == '/profilePage') {
      _currentIndex = 3;
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryButton,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}