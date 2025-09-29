import 'package:flutter/material.dart';
import 'package:urmedio/theme/colors.dart';

class PBottomNavBar extends StatefulWidget {
  const PBottomNavBar({Key? key, required int selectedIndex, required void Function(int index) onItemTapped}) : super(key: key);

  @override
  State<PBottomNavBar> createState() => _PBottomNavBarState();
}

class _PBottomNavBarState extends State<PBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the selected index
    // Note: Use pushReplacementNamed to prevent a back button in the app bar
    // when navigating between main screens.
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/phomePage'); // Assuming home is the root route '/'
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/orderSrc');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/inventry');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/aprofile');
    }
  }

  // A simple method to determine the current index based on the route
  int _getCurrentIndex(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/phomePage') {
      return 0;
    } else if (currentRoute == '/orderSrc') {
      return 1;
    } else if (currentRoute == '/inventry') {
      return 2;
    } else if (currentRoute == '/aprofile') {
      return 3;
    }
    return 0; // Default to dashboard/home
  }

  @override
  Widget build(BuildContext context) {
    // Determine the current index for the bottom navigation bar
    final int currentIndex = _getCurrentIndex(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryButton,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medication),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}