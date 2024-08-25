import 'package:flutter/material.dart';
import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';

class SendResourcePage extends StatefulWidget {
  const SendResourcePage({super.key});

  @override
  _SendResourcePageState createState() => _SendResourcePageState();
}

class _SendResourcePageState extends State<SendResourcePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String selectedDisaster = 'Ongoing disaster'; // Default value for dropdown
  String selectedCategory = 'Select category'; // Default value for dropdown
  String unit = 'kg'; // Default value for unit dropdown

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _nameController.clear();
      _locationController.clear();
      selectedDisaster = 'Ongoing disaster';
      selectedCategory = 'Select category';
      _amountController.clear();
      unit = 'kg';
      _descriptionController.clear();
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Match theme of signup page
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Match theme of signup page
        iconTheme: const IconThemeData(color: Colors.black), // Match theme of signup page
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade100, // Match theme of signup page
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App title matching the theme
                Text(
                  'Provide Resource Details',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800, // Match theme of signup page
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),

                // Form container with consistent styling
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Name TextField
                        TextFormField(
                          controller: _nameController,
                          decoration: _buildInputDecoration(
                            label: 'Name',
                            suffixText: '',
                            helperText: 'Enter your full name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Location TextField
                        TextFormField(
                          controller: _locationController,
                          decoration: _buildInputDecoration(
                            label: 'Location',
                            suffixText: '',
                            helperText: 'Enter the resource location',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the location';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Ongoing Disaster Dropdown
                        DropdownButtonFormField<String>(
                          value: selectedDisaster,
                          decoration: _buildInputDecoration(
                            label: 'Ongoing Disaster',
                            suffixText: '',
                            helperText: 'Select the ongoing disaster',
                          ),
                          items: _buildDropdownMenuItems(
                            ['Ongoing disaster', 'Drought', 'Flood', 'Earthquake'],
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDisaster = newValue ?? 'Ongoing disaster';
                            });
                          },
                          validator: (value) {
                            if (value == 'Ongoing disaster') {
                              return 'Please select a disaster type';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Resource Category Dropdown
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: _buildInputDecoration(
                            label: 'Resource Category',
                            suffixText: '',
                            helperText: 'Select the category of resource',
                          ),
                          items: _buildDropdownMenuItems(
                            ['Select category', 'Clothes', 'Food', 'Medical Equipments'],
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue ?? 'Select category';
                            });
                          },
                          validator: (value) {
                            if (value == 'Select category') {
                              return 'Please select a resource category';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Amount and Unit Field
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _amountController,
                                decoration: _buildInputDecoration(
                                  label: 'Amount',
                                  suffixText: '',
                                  helperText: 'Enter the amount',
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the amount';
                                  }
                                  final double? amount = double.tryParse(value);
                                  if (amount == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: unit,
                                decoration: _buildInputDecoration(
                                  label: 'Unit',
                                  suffixText: '',
                                  helperText: '',
                                ),
                                items: _buildDropdownMenuItems(
                                  ['kg', 'litre', 'millilitre', 'gram', 'dozen', 'pieces'],
                                ),
                                onChanged: (newValue) => setState(() {
                                  unit = newValue ?? 'kg';
                                }),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),

                        // Description Field
                        TextFormField(
                          controller: _descriptionController,
                          decoration: _buildInputDecoration(
                            label: 'Description',
                            suffixText: '',
                            helperText: 'Enter a brief description',
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Collection Fee Display
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
                        const SizedBox(height: 20.0),

                        // Cancel and Confirm Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: _resetForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 30.0),
                              ),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: _confirmSubmission,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 30.0),
                              ),
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: _onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }

  // Helper method to create a consistent InputDecoration
  InputDecoration _buildInputDecoration({
    required String label,
    required String suffixText,
    String? hintText,
    String? helperText,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blue.shade800),
      hintText: hintText,
      helperText: helperText,
      helperStyle: const TextStyle(color: Colors.blueGrey),
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.black),
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue.shade300, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue.shade800, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    );
  }

  // Helper method to create dropdown menu items
  List<DropdownMenuItem<String>> _buildDropdownMenuItems(List<String> items) {
    return items.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Row(
          children: [
            Icon(Icons.arrow_right, color: Colors.blue.shade800),
            const SizedBox(width: 8.0),
            Text(value),
          ],
        ),
      );
    }).toList();
  }
}
