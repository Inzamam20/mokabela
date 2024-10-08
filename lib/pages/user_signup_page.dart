import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:disaster_hackathon_app/main.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  _UserSignUpPageState createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
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
    final name = _nameController.text.trim();
    final phoneNo = _phoneController.text.trim();
    final address = _addressController.text.trim();

    // Check if any field is empty
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        phoneNo.isEmpty ||
        _selectedDate == null ||
        address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final userMetaData = {
      'name': name,
      'phone_no': phoneNo,
      'gender': _selectedGender,
      'dob': _selectedDate?.toIso8601String(),
      'address': address,
    };

    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: userMetaData,
      );

      if (response.user == null) {
        // Handle the case where no user is returned
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Sign-up failed: ${response.user ?? 'Unknown error'}')),
        );
        return;
      }

      print('User created successfully: ${response.user!.id}');
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      // Handle error based on the exception type
      String errorMessage = 'An unknown error occurred';

      if (e is AuthException) {
        errorMessage = 'AuthException: ${e.message} $e';
      } else if (e is Exception) {
        errorMessage = 'Exception: ${e.toString()}';
      }

      print('Sign-up error: $errorMessage \nData:${userMetaData.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during sign-up: $errorMessage')),
      );
    }
  }

  // Updated Google sign-in method
  Future<AuthResponse> signInWithGoogle() async {
    try {
      // Load environment variables
      await dotenv.load();

      final String iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID']!;
      final String androidClientId = dotenv.env['GOOGLE_ANDROID_CLIENT_ID']!;
      final String webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID']!;

      // Use the correct client ID based on the platform
      final String clientId = Platform.isAndroid ? androidClientId : iosClientId;

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: clientId,
        serverClientId: webClientId,
        scopes: [
          'email',
          'profile',
        ],
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In aborted.');
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw Exception('No Access Token found.');
      }
      if (idToken == null) {
        throw Exception('No ID Token found.');
      }

      // Sign in with Google
      final AuthResponse response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      // Update user metadata after successful sign-in
      final userMetaData = {
        'name': googleUser.displayName,
        'email': googleUser.email,
        'gender': 'Male', // You can get this from a form or other source
        'dob': '2000-01-01', // You can get this from a form or other source
        'address': 'Dhanmondi', // You can get this from a form or other source
        'phone_no': '01xxxxxxxxx', // You can get this from a form or other source
      };

      final UserAttributes attributes = UserAttributes(data: userMetaData);

      await supabase.auth.updateUser(attributes);

      return response;
    } catch (e) {
      // Improved error handling logic
      throw Exception('Google Sign-In failed: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Match theme of login page
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Match theme of login page
        iconTheme: const IconThemeData(color: Colors.black), // Match theme of login page
        elevation: 0, // Match theme of login page
      ),
      backgroundColor: Colors.blue.shade100, // Match theme of login page
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App title matching the theme
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800, // Match theme of login page
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
                  child: Column(
                    children: [
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
                          backgroundColor: Colors.blue.shade800, // Match theme of login page
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
                        onPressed: () async {
                          try {
                            final AuthResponse response = await signInWithGoogle();
                            if (response.user != null) {
                              Navigator.pushNamed(context, '/home');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Sign-in failed. Please try again.')),
                              );
                            }
                          } catch (e) {
                            print('Error: ${e.toString()}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('An error occurred: ${e.toString()}')),
                            );
                          }
                        },
                        icon: Image.asset(
                          'assets/icons/google_icon.png', // Path to the Google icon image
                          height: 24.0, // Set the icon size
                          width: 24.0, // Set the icon size
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
                      const SizedBox(height: 20.0),

                      // Already have an account? Sign In
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/user_login');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.blue.shade800), // Match theme of login page
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
      labelStyle: TextStyle(color: Colors.blue.shade800), // Match theme of login page
      hintText: hintText,
      helperText: helperText,
      helperStyle: const TextStyle(color: Colors.blueGrey), // Helper text style
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.black), // Suffix text style
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue.shade300, width: 1.0), // Match theme of login page
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue.shade800, width: 2.0), // Match theme of login page
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Adjust content padding
    );
  }
}
