// forgot_password_page.dart
import 'package:flutter/material.dart';

class VolunteerForgotPasswordPage extends StatelessWidget {
  const VolunteerForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Match theme of other pages
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Match theme of other pages
        iconTheme: const IconThemeData(
            color: Colors.black), // Match theme of other pages
        elevation: 0, // Match theme of other pages
      ),
      backgroundColor: Colors.blue.shade100, // Match theme of other pages
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title text
                Text(
                  'Enter your email to receive OTP',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800, // Match theme of other pages
                  ),
                ),
                const SizedBox(height: 40.0),

                // Email TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color:
                            Colors.blue.shade800), // Match theme of other pages
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                          color: Colors
                              .blue.shade800), // Match theme of other pages
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                          color: Colors
                              .blue.shade800), // Match theme of other pages
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20.0),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Send OTP Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/volunteer_otp'); // Navigate to OTP Page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue.shade800, // Match theme of other pages
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
