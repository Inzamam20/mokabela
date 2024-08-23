import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onTabTapped;
  final int currentIndex;

  const BottomNavBar({super.key, required this.onTabTapped, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data:
          MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(0.77)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Background color
        selectedItemColor: Colors.black, // Selected item color
        unselectedItemColor: Colors.black, // Unselected item color
        showUnselectedLabels: true, // Ensure unselected labels are shown
        showSelectedLabels: true, // Ensure selected labels are shown
        selectedFontSize:
            14.0, // Ensure the selected label font size is the same as the unselected
        unselectedFontSize:
            14.0, // Ensure the unselected label font size is the same as the selected
        selectedIconTheme: const IconThemeData(
            size: 24.0), // Set the icon size for the selected icon
        unselectedIconTheme: const IconThemeData(
            size: 24.0), // Set the icon size for the unselected icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Disasters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction), // "Prepare" icon in the middle
            label: 'Prepare',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Hotline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
