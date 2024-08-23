import 'package:flutter/material.dart';
import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';

class TrackResourcePage extends StatefulWidget {
  const TrackResourcePage({super.key});

  @override
  _TrackResourcePageState createState() => _TrackResourcePageState();
}

class _TrackResourcePageState extends State<TrackResourcePage> {
  String selectedFilter = 'All';

  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add any navigation logic here if needed
  }

  // Mocked resource list
  final List<Map<String, String>> resources = [
    {'type': 'Requested', 'title': 'Rice', 'date': 'Tue 3 Apr 2024 5:02 pm'},
    {'type': 'Requested', 'title': 'Oil', 'date': 'Mon 2 Mar 2024 12:00 pm'},
    {'type': 'Requested', 'title': 'Flour', 'date': 'Fri 7 Jun 2024 11:30 am'},
    {'type': 'Sent', 'title': 'Sugar', 'date': 'Wed 5 May 2024 9:15 am'},
    {'type': 'Sent', 'title': 'Salt', 'date': 'Thu 10 Feb 2024 2:45 pm'},
    {'type': 'Sent', 'title': 'Beans', 'date': 'Sat 13 Jan 2024 8:20 am'},
    {'type': 'Sent', 'title': 'Lentils', 'date': 'Sun 21 Jul 2024 4:00 pm'},
    {
      'type': 'Requested',
      'title': 'Clothes',
      'date': 'Sun 21 Jul 2024 4:00 pm'
    },
    {
      'type': 'Requested',
      'title': 'Lentils',
      'date': 'Sun 21 Jul 2024 4:00 pm'
    },
  ];

  // Filtering resources based on selected filter
  List<Map<String, String>> get filteredResources {
    if (selectedFilter == 'All') {
      return resources;
    } else if (selectedFilter == 'Requested Resource') {
      return resources
          .where((resource) => resource['type'] == 'Requested')
          .toList();
    } else if (selectedFilter == 'Sent Resource') {
      return resources.where((resource) => resource['type'] == 'Sent').toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Resource'),
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
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Padding for the whole page
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0), // Vertical spacing between buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0), // Spacing between buttons
                      child: FilterButton(
                        text: 'All',
                        isSelected: selectedFilter == 'All',
                        onTap: () {
                          setState(() {
                            selectedFilter = 'All';
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0), // Spacing between buttons
                      child: FilterButton(
                        text: 'Requested',
                        isSelected: selectedFilter == 'Requested Resource',
                        onTap: () {
                          setState(() {
                            selectedFilter = 'Requested Resource';
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0), // Spacing between buttons
                      child: FilterButton(
                        text: 'Sent',
                        isSelected: selectedFilter == 'Sent Resource',
                        onTap: () {
                          setState(() {
                            selectedFilter = 'Sent Resource';
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredResources.length,
                itemBuilder: (context, index) {
                  final resource = filteredResources[index];
                  return ResourceCard(
                    resource: resource,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResourceDetailsPage(resource: resource),
                        ),
                      );
                    },
                  );
                },
              ),
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

// FilterButton component
class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton(
      {super.key, required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF215283) : Colors.lightBlue,
        textStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ResourceCard component
class ResourceCard extends StatelessWidget {
  final Map<String, String> resource;
  final VoidCallback onTap;

  const ResourceCard({super.key, required this.resource, required this.onTap});

  IconData _getIconForResourceType(String type) {
    switch (type) {
      case 'Requested':
        return Icons.help;
      case 'Sent':
        return Icons.send;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          _getIconForResourceType(resource['type'] ?? 'Unknown'),
          color: Colors.green,
        ),
        title: Text(resource['title'] ?? 'Unknown Title'),
        subtitle: Text(
          '${resource['type']?.toUpperCase() ?? 'UNKNOWN'} - ${resource['date'] ?? 'Unknown Date'}',
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }
}

// ResourceDetailsPage component
class ResourceDetailsPage extends StatelessWidget {
  final Map<String, String> resource;

  const ResourceDetailsPage({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          resource['title'] ?? 'Resource Details',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusUpdates(),
            const SizedBox(height: 24),
            _buildProductDescription(),
            const SizedBox(height: 24),
            // _buildSellerInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusUpdates() {
    final List<Map<String, String>> trackingHistory = [
      {
        'status': 'Order has been delivered to the designated person',
        'date': 'May 17, 2024 1:30 PM'
      },
      {
        'status': 'Order has been assigned to (Md. Abbas Uddin) for delivery',
        'date': 'May 17, 2024 10:26 AM'
      },
      {
        'status': 'Order has been reached at delivery hub',
        'date': 'May 17, 2024 8:03 AM'
      },
      {'status': 'New order pickup requested', 'date': 'May 16, 2024 7:15 PM'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          ' Tracking History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 2.0,
          child: Column(
            children: trackingHistory.map((history) {
              return ListTile(
                leading: const Icon(Icons.circle, color: Colors.green, size: 15),
                title: Text(history['status'] ?? 'Unknown Status'),
                subtitle: Text(history['date'] ?? 'Unknown Date'),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDescription() {
    String description = '';
    switch (resource['title']) {
      case 'Rice':
        description =
            'High-quality basmati rice, known for its aromatic fragrance and long grains. Perfect for making biryani and pilaf.';
        break;
      case 'Oil':
        description =
            'Pure sunflower oil, ideal for cooking and frying. It has a high smoke point and is rich in vitamin E.';
        break;
      case 'Flour':
        description =
            'All-purpose wheat flour, suitable for baking bread, cakes, and pastries. Made from the finest quality wheat.';
        break;
      case 'Sugar':
        description =
            'Refined white sugar, perfect for sweetening beverages and baking. It dissolves quickly and evenly.';
        break;
      case 'Salt':
        description =
            'Iodized table salt, essential for seasoning and preserving food. Ensures proper thyroid function.';
        break;
      case 'Beans':
        description =
            'Dried kidney beans, rich in protein and fiber. Ideal for making soups, stews, and salads.';
        break;
      case 'Lentils':
        description =
            'Green lentils, a great source of protein and iron. Cooks quickly and is perfect for soups and salads.';
        break;
      case 'Clothes':
        description =
            'Assorted clothing items including shirts, pants, and jackets. Suitable for all ages and seasons.';
        break;
      default:
        description = 'No description available.';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '  Product Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Uncomment if needed
  // Widget _buildSellerInfo() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Seller Info',
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(height: 10),
  //       ListTile(
  //         leading: Icon(Icons.store, color: Colors.blue),
  //         title: Text('Emaan', style: TextStyle(fontSize: 16)),
  //       ),
  //     ],
  //   );
  // }
}
