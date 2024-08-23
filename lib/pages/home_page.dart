import 'package:flutter/material.dart';
import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMore = false;
  int currentIndex = 0;
  late PageController _pageController;
  bool isHovered = false;

  final Map<String, String> routeMap = {
    'Send resource': '/sendresource',
    'Seek resource': '/seekresource',
    'Track resource': '/trackresource',
    'Most requested resource': '/mostrequestedresource',
    'Pending requests': '/pendingrequests',
    'Become a volunteer': '/becomevolunteer',
    'Emergency Shelters': '/emergencyshelters', // Added route
    'Post disaster resources': '/postresources',
    'Womens\' Resources': '/womensresources',
    'Children\'s Resources': '/childrensresources',
    'Disability Resources': '/disabilityresources',
    'Contact Us': '/contactus',
    'A': '/routeA',
    'B': '/routeB',
    'C': '/routeC',
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/ongoingdisaster');
        break;
      case 2:
        Navigator.pushNamed(context, '/prepare');
        break;
      case 3:
        Navigator.pushNamed(context, '/hotline');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mokabela',
          style: TextStyle(
            fontSize: 20, // Change the font size here
            fontWeight: FontWeight.bold, // Optional: add more styling if needed
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: const Color(0xFF1565C0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '24/7 helpline @ *247#',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildGridItem('Send resource', Icons.send),
                  _buildGridItem('Seek resource', Icons.search),
                  _buildGridItem('Track resource', Icons.track_changes),
                  _buildGridItem('Most requested resource', Icons.star),
                  _buildGridItem('Pending requests', Icons.pending),
                  _buildGridItem(
                      'Become a volunteer', Icons.volunteer_activism),
                  if (showMore) ...[
                    _buildGridItem('Emergency Shelters',
                        Icons.local_hotel), // Added Emergency Shelters here
                    _buildGridItem('Post disaster resources', Icons.post_add),
                    _buildGridItem("Womens' Resources", Icons.woman),
                    _buildGridItem("Children's Resources", Icons.child_care),
                    _buildGridItem('Disability Resources', Icons.safety_check),
                    _buildGridItem('Contact Us',
                        Icons.contact_mail), // Moved Contact Us here
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            MouseRegion(
              onEnter: (event) => setState(() {
                isHovered = true;
              }),
              onExit: (event) => setState(() {
                isHovered = false;
              }),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isHovered
                      ? Colors.blue.shade600
                      : Colors.blue.shade800, // Change color on hover
                  foregroundColor: Colors.white,
                ),
                child: Text(showMore ? 'Show Less' : 'More'),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildCarousel(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: _onTabTapped,
        currentIndex: currentIndex,
      ),
    );
  }

  Widget _buildGridItem(String title, IconData icon) {
    return Card(
      child: InkWell(
        onTap: () {
          final routeName = routeMap[title];
          if (routeName != null) {
            Navigator.pushNamed(context, routeName);
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.blue.shade800),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 350, // Make it full-width
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: [
                  Image.asset(
                      'assets/Open-plain-with-cracked-mud-and-clear-sky.png',
                      fit: BoxFit.cover),
                  Image.asset('assets/0.61772200_1669633292_assam.jpg',
                      fit: BoxFit.cover),
                  Image.asset('assets/11285851.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => _buildDot(index)),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        width: currentIndex == index ? 12.0 : 8.0,
        height: currentIndex == index ? 12.0 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
