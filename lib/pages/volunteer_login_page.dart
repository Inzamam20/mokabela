import 'package:flutter/material.dart';

class VolunteerLoginPage extends StatelessWidget {
  const VolunteerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volunteer Login',
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
                // Logo or App title with subtle drop shadow for better visual
                Text(
                  'Mokabela',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
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

                // Form card container
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
                      // Email TextField
                      TextField(
                        decoration: _buildInputDecoration(
                          label: 'Email',
                          suffixText: '', // No suffix needed
                          helperText: 'Enter your email address',
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Password TextField
                      TextField(
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
                            Navigator.pushNamed(
                                context, '/volunteer_forgotpassword');
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
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/home'); // Navigate to HomePage on sign in
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 30.0),
                          shadowColor: Colors.blue.shade800.withOpacity(0.5),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Sign Up with Google Button with Google logo
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
                    ],
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
                        Navigator.pushNamed(context,
                            '/volunteer_signup'); // Navigate to SignUpPage
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
            color: Colors.blue.shade300), // Outline border color and width
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
            color: Colors.blue.shade800,
            width: 2.0), // Focused border color and width
      ),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 20.0), // Adjust content padding
    );
  }
}
