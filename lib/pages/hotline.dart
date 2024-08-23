// Ensure this import is correct
import 'package:flutter/material.dart';

class HotlinePage extends StatefulWidget {
  const HotlinePage({super.key});

  @override
  _HotlinePageState createState() => _HotlinePageState();
}

class _HotlinePageState extends State<HotlinePage> {
  final List<Map<String, dynamic>> resources = [
    {'name': 'Rice', 'requests': 10000, 'icon': Icons.rice_bowl},
    {'name': 'Oil', 'requests': 6000, 'icon': Icons.local_grocery_store},
    {'name': 'Drinking Water', 'requests': 5600, 'icon': Icons.local_drink},
    {'name': 'Clothes', 'requests': 3500, 'icon': Icons.dry_cleaning},
    {'name': 'Bread', 'requests': 4200, 'icon': Icons.bakery_dining},
    {'name': 'Medicines', 'requests': 8000, 'icon': Icons.medical_services},
    {'name': 'Tents', 'requests': 7000, 'icon': Icons.house},
    {'name': 'Blankets', 'requests': 6500, 'icon': Icons.bed},
    {'name': 'Sanitary Kits', 'requests': 5000, 'icon': Icons.clean_hands},
    {'name': 'Baby Food', 'requests': 4800, 'icon': Icons.child_friendly},
    {'name': 'Flashlights', 'requests': 4500, 'icon': Icons.flashlight_on},
    {'name': 'First Aid Kits', 'requests': 4300, 'icon': Icons.local_hospital},
    {'name': 'Hygiene Kits', 'requests': 4000, 'icon': Icons.health_and_safety},
    {'name': 'Cooking Utensils', 'requests': 3800, 'icon': Icons.kitchen},
    {'name': 'Generators', 'requests': 3700, 'icon': Icons.power},
  ];

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add navigation logic here based on the index if needed
    // For example:
    // if (index == 0) Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotline',
          style: TextStyle(
            fontSize: 20, // Change the font size here
            fontWeight: FontWeight.bold, // Optional: add more styling if needed
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.blue.shade800,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
