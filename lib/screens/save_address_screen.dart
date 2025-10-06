import 'package:flutter/material.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  // A variable to hold the index of the currently selected address.
  // We use int? to allow for no selection (null).
  int? _selectedAddressIndex;

  // A list of addresses to display.
  final List<Map<String, dynamic>> _addresses = [
    {
      'title': 'Home',
      'icon': Icons.home_outlined,
      'address': '67 Swaminarayan Road, Unit 14, Rajkot, Gujarat 360003',
    },
    {
      'title': 'Office',
      'icon': Icons.work_outline,
      'address': '102 Mahatma Nagar, Flat 8, Rajkot, Gujarat 360005',
    },
    {
      'title': 'Vacation Home',
      'icon': Icons.home_work_outlined,
      'address': '45 Patel Street, Block B2, Rajkot, Gujarat 360001',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Define the primary blue color from the UI
    const primaryBlue = Color.fromARGB(255, 20, 40, 95);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Saved Addresses',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/addNewAdd');
                  // Handle "Add New Address" tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                ),
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Add New Address'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  final addressData = _addresses[index];
                  return _AddressCard(
                    icon: addressData['icon'],
                    title: addressData['title'],
                    address: addressData['address'],
                    isSelected: _selectedAddressIndex == index,
                    onTap: () {
                      // Call setState to update the UI
                      setState(() {
                        // If the tapped address is already selected, unselect it.
                        // Otherwise, select the new address.
                        _selectedAddressIndex =
                            _selectedAddressIndex == index ? null : index;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;

  const _AddressCard({
    required this.icon,
    required this.title,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.black54),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Checkbox(
                  value: isSelected,
                  onChanged: (bool? value) {
                    onTap(); // Use the onTap callback to handle the change
                  },
                  activeColor: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}