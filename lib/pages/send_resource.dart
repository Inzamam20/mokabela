import 'package:disaster_hackathon_app/main.dart';
import 'package:flutter/material.dart';

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

  String? selectedDisaster; // Make this nullable to avoid the error
  String? selectedCategory; // Make this nullable to avoid the error
  String unit = 'kg'; // Default value for unit dropdown

  List<Map<String, dynamic>> _disasters = [];
  List<Map<String, dynamic>> _categories = [];

  int? _selectedDisasterId;
  int? _selectedCategoryId;

  bool _isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final disasterResponse =
          await supabase.from('disaster').select('id, title');
      final categoryResponse =
          await supabase.from('resource_category').select();

      if (mounted) {
        setState(() {
          _disasters = List<Map<String, dynamic>>.from(disasterResponse);
          _categories = List<Map<String, dynamic>>.from(categoryResponse);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching data: $e')),
        );
      }
    }
  }

  void _resetForm() {
    if (mounted) {
      _formKey.currentState?.reset();
      setState(() {
        _nameController.clear();
        _locationController.clear();
        selectedDisaster = null; // Reset to null
        selectedCategory = null; // Reset to null
        _amountController.clear();
        unit = 'kg';
        _descriptionController.clear();
        _selectedDisasterId = null;
        _selectedCategoryId = null;
      });
    }
  }

  void _confirmSubmission() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await supabase.from('send_resource').insert({
        'name': _nameController.text,
        'sender_id': supabase.auth.currentUser?.id,
        'sender_location': _locationController.text,
        'disaster_id': _selectedDisasterId,
        'resource_category_id': _selectedCategoryId,
        'amount': double.tryParse(_amountController.text),
        'units': unit,
        'description': _descriptionController.text,
        'collection_fee': 50, // Set the collection fee
        'status': 'pending'
      });

      if (mounted) {
        if (response.error == null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title:
                  const Icon(Icons.check_circle, color: Colors.green, size: 50),
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
          _resetForm();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Error inserting data: ${response.error!.message}')),
          );
        }
      }
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
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade100,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show a loading indicator
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Provide Resource Details',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Name input
                              TextFormField(
                                controller: _nameController,
                                decoration: _buildInputDecoration(
                                  label: 'Resource Name',
                                  suffixText: '',
                                  helperText: 'Enter the name of the resource',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the resource name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),

                              // Location input
                              TextFormField(
                                controller: _locationController,
                                decoration: _buildInputDecoration(
                                  label: 'Sender Location',
                                  suffixText: '',
                                  helperText:
                                      'Enter the location of the sender',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the sender location';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),

                              // Disaster dropdown
                              DropdownButtonFormField<String>(
                                value: selectedDisaster, // Use nullable value
                                decoration: _buildInputDecoration(
                                  label: 'Ongoing Disaster',
                                  suffixText: '',
                                  helperText: 'Select the ongoing disaster',
                                ),
                                items: _buildDropdownMenuItems(
                                  _disasters
                                      .map((d) => d['title'].toString())
                                      .toList(),
                                ),
                                onChanged: (String? newValue) {
                                  if (mounted) {
                                    setState(() {
                                      selectedDisaster =
                                          newValue ?? 'Select disaster';
                                      _selectedDisasterId =
                                          _disasters.firstWhere(
                                        (d) => d['title'] == newValue,
                                        orElse: () => {},
                                      )['id'] as int?;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a disaster type';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),

                              // Category dropdown
                              DropdownButtonFormField<String>(
                                value: selectedCategory, // Use nullable value
                                decoration: _buildInputDecoration(
                                  label: 'Resource Category',
                                  suffixText: '',
                                  helperText: 'Select the category of resource',
                                ),
                                items: _buildDropdownMenuItems(
                                  _categories
                                      .map((c) => c['name'].toString())
                                      .toList(),
                                ),
                                onChanged: (String? newValue) {
                                  if (mounted) {
                                    setState(() {
                                      selectedCategory =
                                          newValue ?? 'Select category';
                                      _selectedCategoryId =
                                          _categories.firstWhere(
                                        (c) => c['name'] == newValue,
                                        orElse: () => {},
                                      )['id'] as int?;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a resource category';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),

                              // Amount input
                              TextFormField(
                                controller: _amountController,
                                decoration: _buildInputDecoration(
                                  label: 'Amount',
                                  suffixText: '',
                                  helperText: 'Enter the amount of resource',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the amount';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),

                              // Unit dropdown
                              DropdownButtonFormField<String>(
                                value: unit,
                                decoration: _buildInputDecoration(
                                  label: 'Unit',
                                  suffixText: '',
                                  helperText: 'Select the unit of measurement',
                                ),
                                items: [
                                  'kg',
                                  'liters',
                                  'pieces'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (mounted) {
                                    setState(() {
                                      unit = newValue ?? 'kg';
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 20.0),

                              // Description input
                              TextFormField(
                                controller: _descriptionController,
                                decoration: _buildInputDecoration(
                                  label: 'Description',
                                  suffixText: '',
                                  helperText:
                                      'Enter a description for the resource',
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

                              // Submit button
                              ElevatedButton(
                                onPressed: _confirmSubmission,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.blue.shade800, // Background color
                                  foregroundColor: Colors.white, // Text color
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                child: const Text('Submit'),
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
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required String suffixText,
    required String helperText,
  }) {
    return InputDecoration(
      labelText: label,
      suffixText: suffixText,
      helperText: helperText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      filled: true,
      fillColor: Colors.grey.shade200,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems(List<String> items) {
    return items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
