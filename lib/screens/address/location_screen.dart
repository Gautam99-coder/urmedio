import 'package:flutter/material.dart';
import 'package:urmedio/models/address_model.dart';
import 'package:urmedio/screens/address/addnewaddress_screen.dart'; // Import the Address model

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // Initial list of saved addresses
  List<Address> _savedAddresses = [
    Address(
      line1: '123 Main Street',
      line2: 'Near Central Park',
      city: 'Gautam',
      state: 'RK',
      postalCode: 'D8009',
      country: 'India',
    ),
    // You can add more initial addresses here
  ];

  // Function to navigate and wait for a new address
  void _navigateToAddAddress() async {
    final newAddress = await Navigator.push<Address?>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewAddressScreen(),
      ),
    );

    // If a new address was returned, add it to the list and rebuild the UI
    if (newAddress != null) {
      setState(() {
        _savedAddresses.insert(0, newAddress); // Add at the top
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color.fromARGB(255, 20, 40, 95);

    // The logic to decide between showing Pharmacy Cards or Saved Addresses
    // For this implementation, we will replace the repeating Pharmacy Cards
    // with the dynamic list of saved addresses.

    // A list of widgets to be placed in the DraggableScrollableSheet
    List<Widget> sheetContent = [];

    // --- Filter Buttons (from your original code) ---
    sheetContent.add(
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterButton(context, 'Open Now', primaryBlue, Colors.white),
            const SizedBox(width: 8),
            _buildFilterButton(context, '24x7', Colors.grey[200]!, Colors.black54),
            const SizedBox(width: 8),
            _buildFilterButton(context, 'Delivery Available', Colors.grey[200]!, Colors.black54),
            const SizedBox(width: 8),
            _buildFilterButton(context, 'Pharmacy', Colors.grey[200]!, Colors.black54),
          ],
        ),
      ),
    );
    sheetContent.add(const SizedBox(height: 24));


    // --- Add New Address Button (new) ---
    sheetContent.add(
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _navigateToAddAddress,
          icon: const Icon(Icons.add_location_alt_outlined, size: 20, color: primaryBlue),
          label: const Text(
            'Add New Address',
            style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold),
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: primaryBlue, width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
    sheetContent.add(const SizedBox(height: 24));


    // --- Saved Address Cards (replaces Pharmacy Cards) ---
    sheetContent.add(
      const Text(
        'Saved Addresses',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
    sheetContent.add(const SizedBox(height: 12));

    if (_savedAddresses.isEmpty) {
      sheetContent.add(
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No addresses saved yet. Tap "Add New Address" above to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    } else {
      // Dynamically generate address cards
      for (var address in _savedAddresses) {
        sheetContent.add(_buildAddressCard(context, address));
      }
    }

    sheetContent.add(const SizedBox(height: 20)); // Padding at the bottom

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Map Placeholder
          Positioned.fill(
            child: Image.asset(
              'assets/images/location.png', // Replace with your static map image
              fit: BoxFit.cover,
            ),
          ),

          // 🚀 BACK BUTTON (FIXED AND CLEAN)
          Positioned(
            top: 40,
            left: 16,
            child: SafeArea(
              bottom: false,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),

          // Zoom and Location controls
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.45,
            right: 16.0,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    // Handle zoom in
                  },
                  child: const Icon(Icons.add, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    // Handle zoom out
                  },
                  child: const Icon(Icons.remove, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    // Handle user location button
                  },
                  child: const Icon(Icons.my_location, color: primaryBlue),
                ),
              ],
            ),
          ),

          // Draggable Bottom Sheet for saved addresses
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Draggable handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...sheetContent, // Use the generated list of widgets
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Your original _buildFilterButton function
  Widget _buildFilterButton(BuildContext context, String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        // Handle filter tap
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        elevation: 0,
      ),
      child: Text(text),
    );
  }

  // Modified function to build an Address Card (based on your original _buildPharmacyCard)
  Widget _buildAddressCard(BuildContext context, Address address) {
    const primaryBlue = Color.fromARGB(255, 20, 40, 95);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saved Home Address', // A generic title for a saved address
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address.fullAddress, // Use the full address from the model
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Handle "Edit/Select" tap
                    },
                    icon: const Icon(Icons.edit_location_alt_outlined, size: 20, color: primaryBlue),
                    label: const Text(
                      'Select Address',
                      style: TextStyle(color: primaryBlue),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: primaryBlue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Placeholder for a location icon/map thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue[50], // Light blue placeholder color
                child: const Icon(Icons.map, size: 40, color: primaryBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}