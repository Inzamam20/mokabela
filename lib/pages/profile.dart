// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late File _profileImage;
  bool _isImageSelected = false;
  // final picker = ImagePicker();

  String _phone = '+8801234567812';
  String _address = 'Banani, Dhaka';
  String _dateJoined = 'June 26, 2024';
  bool _notificationsEnabled = true;
  bool _isDarkTheme = false;
  String _language = 'English';

  @override
  void initState() {
    super.initState();
    _loadDefaultImage();
  }

  Future<void> _loadDefaultImage() async {
    setState(() {
      _profileImage = File(
          'assets/profile-icon-design-free-vector.jpg'); // Load default image
    });
  }

  Future<void> _pickImage() async {
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   setState(() {
    //     _profileImage = File(pickedFile.path);
    //     _isImageSelected = true;
    //   });
    // }
  }

  void _showEditDialog(
      String title, String currentValue, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $title'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _chooseLanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['English', 'Spanish', 'French', 'German']
                .map((lang) => ListTile(
                      title: Text(lang),
                      onTap: () {
                        setState(() {
                          _language = lang;
                        });
                        Navigator.of(context).pop();
                      },
                    ))
                .toList(),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
      ), // Custom AppBar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _isImageSelected
                      ? FileImage(_profileImage)
                      : AssetImage('assets/profile-icon-design-free-vector.jpg')
                          as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(Icons.edit, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildProfileCard(
                title: 'Phone',
                content: _buildProfileItem('Phone', _phone, (newValue) {
                  setState(() {
                    _phone = newValue;
                  });
                }),
              ),
              _buildProfileCard(
                title: 'Address',
                content: _buildProfileItem('Address', _address, (newValue) {
                  setState(() {
                    _address = newValue;
                  });
                }),
              ),
              _buildProfileCard(
                title: 'Date Joined',
                content: _buildDateJoinedItem('Date Joined', _dateJoined),
              ),
              _buildProfileCard(
                title: 'Notifications',
                content: _buildToggleItem(
                    'Notifications', _notificationsEnabled, (newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                }),
              ),
              _buildProfileCard(
                title: 'Language',
                content: _buildLanguageChooser(
                    'Language', _language, _chooseLanguage),
              ),
              _buildProfileCard(
                title: 'Theme',
                content:
                    _buildThemeToggleItem('Theme', _isDarkTheme, (newValue) {
                  setState(() {
                    _isDarkTheme = newValue;
                  });
                }),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // FAQs action
                },
                child: Text('FAQs'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: (index) {
          // Handle tab taps
        },
        currentIndex: 3, // Assuming Profile tab is at index 3
      ),
    );
  }

  Widget _buildProfileCard({required String title, required Widget content}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
      String title, String value, Function(String) onSave) {
    return ListTile(
      title: Text(value),
      trailing: title != 'Date Joined'
          ? Icon(Icons.edit)
          : null, // No edit icon for Date Joined
      onTap: title != 'Date Joined'
          ? () {
              _showEditDialog(title, value, onSave);
            }
          : null, // No action for Date Joined
    );
  }

  Widget _buildDateJoinedItem(String title, String value) {
    return ListTile(
      title: Text(value),
    );
  }

  Widget _buildToggleItem(
      String title, bool currentValue, Function(bool) onSave) {
    return ListTile(
      title: Text(''),
      trailing: Switch(
        value: currentValue,
        onChanged: onSave,
      ),
    );
  }

  Widget _buildLanguageChooser(
      String title, String currentValue, VoidCallback onChoose) {
    return ListTile(
      title: Text(''),
      subtitle: Text(currentValue),
      trailing: ElevatedButton(
        onPressed: onChoose,
        child: Text('Choose'),
      ),
    );
  }

  Widget _buildThemeToggleItem(
      String title, bool currentValue, Function(bool) onSave) {
    return ListTile(
      title: Text(''),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(currentValue ? Icons.nights_stay : Icons.wb_sunny),
          Switch(
            value: currentValue,
            onChanged: onSave,
          ),
        ],
      ),
    );
  }
}
