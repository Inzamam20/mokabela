import 'package:flutter/material.dart';
import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';
import 'package:disaster_hackathon_app/components/top_nav_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {
      'timestamp': 'Thu 18 Nov 2023 - 12:03 pm',
      'message': 'Your resource has reached Dhaka Hub'
    },
    {
      'timestamp': 'Wed 17 Nov 2023 - 10:25 am',
      'message': 'Resource is being processed at central warehouse'
    },
    {
      'timestamp': 'Tue 16 Nov 2023 - 9:45 am',
      'message': 'Resource dispatched from local center'
    },
    {
      'timestamp': 'Mon 15 Nov 2023 - 2:30 pm',
      'message': 'Resource request has been approved'
    },
  ];

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add navigation logic here based on the index if needed
    // Example:
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/ongoing_disaster');
        break;
      case 2:
        Navigator.pushNamed(context, '/hotline');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(title: 'Notifications'),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30,
              ),
              title: Text(
                notifications[index]['timestamp'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notifications[index]['message'] ?? ''),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: _onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}
