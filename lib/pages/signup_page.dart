import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Variables to store selected date and form inputs
  DateTime? _selectedDate;
  String _selectedGender = 'Male'; // Default gender
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Method to handle date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date as the initial date
      firstDate: DateTime(1900), // Earliest date allowed
      lastDate: DateTime.now(), // Latest date allowed
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Method to handle sign-up logic
  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password cannot be empty')),
      );
      return;
    }

    // Prepare data to be inserted into the `user` table
    final userData = {
      'email_address': email,
      'name': _nameController.text.trim(),
      'password': password, // Store the password (consider hashing)
      'phone_number': _phoneController.text.trim(),
      'gender': _selectedGender, // Store gender as text
      'dob': _selectedDate
          ?.toIso8601String()
          .substring(0, 10), // Date in 'YYYY-MM-DD' format
      'address': _addressController.text.trim(),
      'created_at':
          DateTime.now().toIso8601String(), // Store the current timestamp
    };

    // Insert the data into the `user` table
    try {
      final response =
          await Supabase.instance.client.from('user').insert(userData);

      if (response == null) {
        print('Supabase response is null');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No response from Supabase')),
        );
        return;
      }

      if (response.error != null) {
        // An error occurred
        print('Supabase error: ${response.error!.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.error!.message)),
        );
      } else {
        // No errors, proceed to the next step
        print('User created successfully');
        print(response.data);
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      // Catch and print any other exceptions
      print('Sign-up error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during sign-up')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or App title
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 40.0),

                // Name TextField
                TextField(
                  controller: _nameController,
                  decoration: _buildInputDecoration(
                    label: 'Name',
                    suffixText: '',
                    helperText: 'Enter your full name',
                  ),
                ),
                const SizedBox(height: 20.0),

                // Email TextField
                TextField(
                  controller: _emailController,
                  decoration: _buildInputDecoration(
                    label: 'Email',
                    suffixText: '',
                    helperText: 'Enter your email address',
                  ),
                ),
                const SizedBox(height: 20.0),

                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _buildInputDecoration(
                    label: 'Password',
                    suffixText: '',
                    helperText: 'Enter a secure password',
                  ),
                ),
                const SizedBox(height: 20.0),

                // Phone Number TextField
                TextField(
                  controller: _phoneController,
                  decoration: _buildInputDecoration(
                    label: 'Phone Number',
                    suffixText: '',
                    helperText: 'Enter your phone number',
                  ),
                ),
                const SizedBox(height: 20.0),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: _buildInputDecoration(
                    label: 'Gender',
                    suffixText: '',
                    helperText: 'Select your gender',
                  ),
                  items: ['Male', 'Female', 'Others']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (String? newGender) {
                    setState(() {
                      _selectedGender = newGender!;
                    });
                  },
                ),
                const SizedBox(height: 20.0),

                // Date of Birth Field with DatePicker
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: _buildInputDecoration(
                      label: 'Date of Birth',
                      suffixText: '',
                      helperText: 'Select your date of birth',
                      hintText: _selectedDate != null
                          ? "${_selectedDate!.toLocal()}".split(' ')[0]
                          : 'Select your date of birth',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Home Address TextField
                TextField(
                  controller: _addressController,
                  decoration: _buildInputDecoration(
                    label: 'Home Address',
                    suffixText: '',
                    helperText: 'Enter your home address',
                  ),
                ),
                const SizedBox(height: 20.0),

                // Sign Up Button
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Sign Up with Google Button
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle Google sign up
                  },
                  icon: Image.asset(
                    'assets/icons/google_icon.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                  label: const Text(
                    'Sign Up with Google',
                    style: TextStyle(fontSize: 16.0, color: Colors.red),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                  ),
                ),

                // Already have an account? Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blue.shade800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
        borderSide: BorderSide(color: Colors.blue.shade200, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue.shade800, width: 2.0),
      ),
    );
  }
}
