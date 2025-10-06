import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color.fromARGB(255, 20, 40, 95);

    return Scaffold(
      // Setting the background color of the Scaffold to handle any gaps
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Map Placeholder (Positioned.fill)
          Positioned.fill(
            child: Image.asset(
              'assets/images/location.png', // Replace with the path to your static map image
              fit: BoxFit.cover, // Ensures the image fills the entire area
            ),
          ),

          // 🚀 BACK BUTTON (FIXED AND CLEAN)
          Positioned(
            top: 40, // Adjust this value for better placement relative to the status bar
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
                    Navigator.pop(context); // Go back to the previous screen
                  },
                ),
              ),
            ),
          ),

          // Zoom and Location controls (Existing code)
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

          // Draggable Bottom Sheet for pharmacy details (Existing code)
          DraggableScrollableSheet(
            initialChildSize: 0.35, // Initial height of the sheet
            minChildSize: 0.35, // Minimum height when dragged down
            maxChildSize: 0.8, // Maximum height when dragged up
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
                        // Filter buttons
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
                        const SizedBox(height: 24),
                        // Pharmacy card list (Repeating this for scrollability)
                        _buildPharmacyCard(context),
                        _buildPharmacyCard(context),
                        _buildPharmacyCard(context),
                        _buildPharmacyCard(context),
                        _buildPharmacyCard(context),
                        const SizedBox(height: 20), // Padding at the bottom
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

  Widget _buildPharmacyCard(BuildContext context) {
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
                    'Gautam Pharmacy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '123 Main Street,Gautam, RK D8009',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pharmacyDetail');
                      // Handle "View Details" tap
                    },
                    icon: const Icon(Icons.info_outline, size: 20, color: primaryBlue),
                    label: const Text(
                      'View Details',
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/pharmacy.png', // Placeholder asset
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}