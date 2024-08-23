import 'package:flutter/material.dart';
import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';
import 'package:disaster_hackathon_app/components/top_nav_bar.dart';

class OngoingDisasterPage extends StatefulWidget {
  const OngoingDisasterPage({super.key});

  @override
  _OngoingDisasterPageState createState() => _OngoingDisasterPageState();
}

class _OngoingDisasterPageState extends State<OngoingDisasterPage> {
  int _currentIndex = 1; // Assuming this page is index 1 in BottomNavBar

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        break; // Current page, do nothing or handle refresh if needed
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
      appBar: AppBar(
        title: const Text('Disasters'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            OngoingDisasterCard(
              title: 'Landslide Post Disaster Programme',
              location: 'Chittagong',
              isPost: true,
            ),
            OngoingDisasterCard(
              title: 'Flash Floods Resource Collection',
              location: 'Sylhet',
              isOngoing: true,
            ),
            OngoingDisasterCard(
              title: 'Fire in RMG Factory',
              location: 'Savar, Tongi',
              isPost: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: _onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}

class OngoingDisasterCard extends StatefulWidget {
  final String title;
  final String location;
  final bool isPost;
  final bool isOngoing;

  const OngoingDisasterCard({super.key, 
    required this.title,
    required this.location,
    this.isPost = false,
    this.isOngoing = false,
  });

  @override
  _OngoingDisasterCardState createState() => _OngoingDisasterCardState();
}

class _OngoingDisasterCardState extends State<OngoingDisasterCard> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OngoingDisasterDetailPage(
              title: widget.title,
              location: widget.location,
              isOngoing: widget.isOngoing,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: widget.isPost
                          ? Colors.red.shade100
                          : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    child: Text(
                      widget.isPost ? 'Post' : 'Ongoing',
                      style: TextStyle(
                        color: widget.isPost ? Colors.red : Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Area: ${widget.location}'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: isFollowing ? Colors.grey : Colors.blue,
                      minimumSize: const Size(70, 30),
                    ),
                    onPressed: () {
                      setState(() {
                        isFollowing = !isFollowing;
                      });
                    },
                    child: Text(isFollowing ? 'Following' : 'Follow'),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.chevron_right, size: 50, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OngoingDisasterDetailPage(
                            title: widget.title,
                            location: widget.location,
                          ),
                        ),
                      ).then((_) {
                        // Handle any post-navigation actions if needed
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OngoingDisasterDetailPage extends StatelessWidget {
  final String title;
  final String location;
  final bool isOngoing;

  const OngoingDisasterDetailPage({super.key, 
    required this.title,
    required this.location,
    this.isOngoing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                _buildDisasterDetails(title), // Display details based on title
                const SizedBox(height: 16),
                const Divider(),
                _buildStatisticsSection(), // Display statistics
                const SizedBox(height: 16),
                const Divider(),
                const Text(
                  'Top Resources:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildTopResourcesSection(), // Display top resources
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisasterDetails(String title) {
    switch (title) {
      case 'Landslide Post Disaster Programme':
        return const Text(
          'A massive landslide in Chittagong has caused significant damage, leading to loss of lives and property. Efforts are ongoing to clear debris and provide aid to affected families.',
          style: TextStyle(fontSize: 16),
        );
      case 'Flash Floods Resource Collection':
        return const Text(
          'Flash floods in Sylhet have inundated large areas, displacing thousands. Relief efforts are concentrated on providing shelter, food, and medical aid to the flood victims.',
          style: TextStyle(fontSize: 16),
        );
      case 'Fire in RMG Factory':
        return const Text(
          'A devastating fire broke out in an RMG factory in Savar, Tongi, causing severe damage. Rescue operations are ongoing, with efforts focused on finding survivors and providing medical assistance.',
          style: TextStyle(fontSize: 16),
        );
      default:
        return const SizedBox.shrink(); // Handle any other cases or defaults
    }
  }

  Widget _buildStatisticsSection() {
    return Column(
      children: [
        _buildStatRow('Current Volunteers', '1100'),
        _buildStatRow('Resources Delivered', '800'),
        _buildStatRow('On the Way', '500'),
        _buildStatRow('Days Elapsed', '10'),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTopResourcesSection() {
    return Column(
      children: [
        _buildTopResourceCard(Icons.rice_bowl, 'Rice', '10000'),
        _buildTopResourceCard(Icons.local_grocery_store, 'Oil', '6000'),
        _buildTopResourceCard(Icons.local_drink, 'Drinking Water', '5600'),
        _buildTopResourceCard(Icons.checkroom, 'Clothes', '3500'),
        _buildTopResourceCard(Icons.bakery_dining, 'Bread', '4200'),
        _buildTopResourceCard(Icons.medical_services, 'Medicines', '8000'),
      ],
    );
  }

  Widget _buildTopResourceCard(IconData icon, String title, String requests) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Requests: $requests'),
      ),
    );
  }
}
