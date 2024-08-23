// send_resource.dart

import 'package:flutter/material.dart';
import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';

class SendResourcePage extends StatefulWidget {
  const SendResourcePage({super.key});

  @override
  _SendResourcePageState createState() => _SendResourcePageState();
}

class _SendResourcePageState extends State<SendResourcePage> {
  final _formKey = GlobalKey<FormState>();
  String currentLocation = '';
  String selectedDisaster = 'Drought';
  String selectedCategory = 'Clothes';
  String weight = '';
  String quantity = '';
  String description = '';

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add any navigation logic here if needed
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      currentLocation = '';
      selectedDisaster = 'Drought';
      selectedCategory = 'Clothes';
      weight = '';
      quantity = '';
      description = '';
    });
  }

  void _confirmSubmission() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
          content: const Text(
            'Your resource sending request has been confirmed. '
            'Please keep the items properly prepared beforehand.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Resource',
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Dhanmondi, Dhaka',
                  suffixIcon: ElevatedButton(
                    onPressed: () {
                      // Implement map choosing functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue.shade800,
                      backgroundColor: Colors.lightBlue.shade100,
                    ),
                    child: const Text('Choose on map'),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => setState(() {
                  currentLocation = value;
                }),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Ongoing Disaster',
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: selectedDisaster,
                items: ['Drought', 'Flood', 'Earthquake'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() {
                  selectedDisaster = newValue ?? 'Drought';
                }),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Resource Category',
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: selectedCategory,
                items: ['Clothes', 'Food', 'Medical Equipments']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() {
                  selectedCategory = newValue ?? 'Clothes';
                }),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => setState(() {
                  weight = value;
                }),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => setState(() {
                  quantity = value;
                }),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 3,
                onChanged: (value) => setState(() {
                  description = value;
                }),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Collection Fee:',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Text(
                    '50 Tk',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF215283),
                      foregroundColor:
                          Colors.white, // Custom color for Cancel button
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _confirmSubmission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor:
                          Colors.white, // Custom color for Confirm button
                    ),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: _onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}
