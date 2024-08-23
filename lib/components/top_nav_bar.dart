import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopNavBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Color(0xFF215283), // Background color for the top bar
      title: Text(title),
      centerTitle: true,
    );
  }
}
