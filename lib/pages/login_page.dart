import 'package:disaster_hackathon_app/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:
                Colors.black, // Set the text color to black to match HomePage
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Set AppBar background to white
        iconTheme: const IconThemeData(
            color: Colors.black), // Set back icon color to black
        elevation: 0, // Remove shadow for a cleaner look
      ),
      backgroundColor:
          Colors.blue.shade100, // Same as scaffoldBackgroundColor in main.dart
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or App title
                Text(
                  'Mokabela',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 40.0),

                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: _buildInputDecoration(
                    label: 'Email',
                    suffixText: '', // No suffix needed
                    helperText: 'Enter your email address',
                  ),
                ),
                const SizedBox(height: 20.0),

                // Password TextField
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: _buildInputDecoration(
                    label: 'Password',
                    suffixText: '', // No suffix needed
                    helperText: 'Enter your password',
                  ),
                ),
                const SizedBox(height: 10.0),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Sign In Button
                ElevatedButton(
                  onPressed: () async {
                    // Call the sign-in method
                    await _signInWithEmail(
                      context,
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                  ),
                  child: const Text(
                    'Sign In',
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
                    'assets/icons/google_icon.png', // Path to the Google icon image
                    height: 24.0, // Set the icon size
                    width: 24.0, // Set the icon size
                  ),
                  label: const Text(
                    'Sign In with Google',
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

                // Don't have an account? Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/signup'); // Navigate to SignUpPage
                      },
                      child: Text(
                        'Sign Up',
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

  // Method for signing in with email and password
  Future<void> _signInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final User? user = res.user;

      if (user != null) {
        // Sign-in successful, navigate to home page
        Navigator.pushNamed(context, '/home');
      } else {
        // Handle the case when user is null
        _showErrorDialog(context, 'Sign-in failed. Please try again.');
      }
    } catch (e) {
      // Handle the error properly
      _showErrorDialog(context, 'Error: ${e.toString()}');
    }
  }

  // Helper method to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
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
      labelStyle:
          TextStyle(color: Colors.blue.shade800), // Customize label color
      hintText: hintText,
      helperText: helperText,
      helperStyle: const TextStyle(color: Colors.blueGrey), // Helper text style
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.black), // Suffix text style
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
            color: Colors.blue.shade800), // Outline border color and width
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
            color: Colors.blue.shade800), // Focused border color and width
      ),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0, vertical: 20.0), // Adjust content padding
    );
  }
}
