import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'article_page.dart';

class PreparePage extends StatefulWidget {
  const PreparePage({super.key});

  @override
  _PreparePageState createState() => _PreparePageState();
}

class _PreparePageState extends State<PreparePage> {
  int _currentIndex = 2; // Index for the 'Prepare' tab

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to the appropriate page based on the selected index
    switch (index) {
      case 0:
        // Navigate to Home page
        break;
      case 1:
        // Navigate to Disasters page
        break;
      case 2:
        // Already on the Prepare page
        break;
      case 3:
        // Navigate to Hotline page
        break;
      case 4:
        // Navigate to Profile page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Preparedness Matters'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticlePage(
                    articleTitle:
                        "9 Things to Remember If You Are Under an Extreme Heat Warning",
                    articleContent: [
                      {
                        'title': 'Introduction',
                        'content':
                            'In most of the United States, extreme heat is a long period (two to three days) of high heat and humidity with temperatures above 90 degrees. If you are under an extreme heat warning, here are 9 things to remember to keep you safe.',
                        'image': 'assets/images/heat_warning.webp',
                      },
                      {
                        'title':
                            'Never leave anyone alone inside a hot vehicle',
                        'content':
                            'Young children, the elderly, and disabled individuals left alone in a parked vehicle are at higher risks of suffering from heat stroke. Pets are also at great risk. Vehicles can reach dangerously high temperatures very quickly, even with windows cracked. Always double-check your car before leaving to ensure no one is left behind.',
                        'image': 'assets/images/heat_warning.webp',
                      },
                      {
                        'title': 'Find air conditioning, if possible',
                        'content':
                            'Spend time in air-conditioned locations such as malls and libraries if your home isn\'t air conditioned. Prolonged exposure to high temperatures can cause heat-related illnesses. Public spaces like community centers, shopping malls, and libraries often provide a cool environment during heat waves.',
                        'image': 'assets/images/heat_warning.webp',
                      },
                      {
                        'title': 'Find cooling options',
                        'content':
                            'During extreme heat events, many communities have designated cooling options. These can include cooling centers, public pools, and misting stations. Check local resources and community announcements for available cooling options in your area.',
                        'image': 'assets/images/heat_warning.webp',
                      },
                      // Add more sections here...
                    ],
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                      'assets/images/heat_warning.webp'), // Load image from assets
                  const ListTile(
                    title: Text(
                        "9 Things to Remember If You Are Under an Extreme Heat Warning"),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticlePage(
                    articleTitle:
                        "Do's and Don'ts When You're Driving in a Flood",
                    articleContent: [
                      {
                        'title': 'Introduction',
                        'content':
                            'Driving in a flood can be extremely dangerous and poses significant risks to your safety. Flood waters can rise rapidly, making it difficult to navigate and predict their depth and strength. It\'s crucial to be prepared and aware of the do\'s and don\'ts to ensure your safety and the safety of others. This guide provides essential tips and precautions to follow when encountering flood conditions while driving. By adhering to these guidelines, you can reduce the risk of accidents and increase your chances of staying safe during a flood.',
                        'image': 'assets/images/danger_high_water.jpg',
                      },
                      {
                        'title': 'DO evacuate immediately if told to evacuate',
                        'content':
                            'Only when there\'s a serious threat to public safety is a mandatory evacuation ordered. Listen to local authorities and follow evacuation routes to ensure your safety. Ignoring evacuation orders can put you and your family in serious danger.',
                        'image': 'assets/images/evacuate_flood.jpg',
                      },
                      {
                        'title': 'Do turn around, don\'t drown!',
                        'content':
                            'Every year, people drown because they thought they could make it through flood waters. Do not walk, swim, or drive through flood waters. You never know how deep they can be or what hidden hazards they contain. Six inches of water can knock an adult off their feet, and a foot of moving water can sweep away a vehicle.',
                        'image': 'assets/images/drown_car_in_flood.jpg',
                      },
                      {
                        'title': 'DON\'T drive into flood waters',
                        'content':
                            'You should never risk driving through flood waters. Six inches of moving water can make you lose control of your car. Even when the water looks calm, it can still contain all kinds of hidden hazards like debris, tree branches, and even power lines. Flood waters can also cause your vehicle to stall, leaving you trapped.',
                        'image': 'assets/images/driving_in_flood.webp',
                      },
                      {
                        'title': 'DON\'T drive around local barricades',
                        'content':
                            'Local emergency responders use road barricades to indicate that the road is closed. Driving around them can be dangerous. If you come across a road with a barricade, turn around and find an alternate route. Barricades are in place to protect you from potentially life-threatening situations.',
                        'image': 'assets/images/local_barricade_flood.webp',
                      },
                      {
                        'title':
                            'DON\'T drive onto bridges over fast-moving water',
                        'content':
                            'Fast-moving water can wash bridges away without warning, especially if the water contains heavy debris. Even if the bridge looks safe, it may not be structurally sound. It\'s better to find a safer route than to risk crossing a potentially unstable bridge.',
                        'image': 'assets/images/broken_bridge_flood.jpg',
                      },
                      {
                        'title':
                            'DO stay inside your car if trapped in rapidly moving water',
                        'content':
                            'Remember to get on the roof if water is rising inside the car. Staying inside your car can provide protection from fast-moving debris and a place to wait for rescue. Climbing onto the roof can keep you safe from rising water until help arrives.',
                        'image': 'assets/images/trapped_in_flood_water.webp',
                      },
                      // Add more sections here...
                    ],
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                      'assets/images/danger_high_water.jpg'), // Load image from assets
                  const ListTile(
                    title:
                        Text("Do's and Don'ts When You're Driving in a Flood"),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticlePage(
                    articleTitle: "Wildfires: Are You Prepared?",
                    articleContent: [
                      {
                        'title': 'Introduction',
                        'content':
                            'Wildfires can spread quickly and without warning. Here are some tips to make sure you are prepared.',
                        'image': 'assets/images/wildfire.webp',
                      },
                      {
                        'title': 'Create a Fire-Resistant Zone',
                        'content':
                            'Clear vegetation and other flammable materials around your home to create a fire-resistant zone. This can help prevent the spread of fire to your property. Trim trees and shrubs to create a buffer zone, and keep your lawn well-watered to minimize dry, flammable materials.',
                        'image': 'assets/images/wildfire.webp',
                      },
                      {
                        'title': 'Prepare an Emergency Kit',
                        'content':
                            'Assemble an emergency supply kit that includes water, food, medications, important documents, and other essentials. Keep the kit in an easily accessible location in case you need to evacuate quickly. Ensure everyone in your household knows where it is and what it contains.',
                        'image': 'assets/images/wildfire.webp',
                      },
                      {
                        'title': 'Plan Your Evacuation Route',
                        'content':
                            'Identify multiple evacuation routes from your home and practice using them. Know where to go and how to get there, whether by car, bike, or on foot. Share your plan with family and friends so everyone knows what to do in case of an emergency.',
                        'image': 'assets/images/wildfire.webp',
                      },
                      // Add more sections here...
                    ],
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset('assets/images/wildfire.webp'),
                  const ListTile(
                    title: Text("Wildfires: Are You Prepared?"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: _onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}
