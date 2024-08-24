// ignore_for_file: prefer_const_constructors

import 'package:disaster_hackathon_app/pages/home_page.dart';
import 'package:disaster_hackathon_app/pages/hotline.dart';
import 'package:disaster_hackathon_app/pages/login_page.dart';
import 'package:disaster_hackathon_app/pages/most_requested_resource.dart';
import 'package:disaster_hackathon_app/pages/notification.dart';
import 'package:disaster_hackathon_app/pages/ongoing_disaster.dart';
import 'package:disaster_hackathon_app/pages/prepare_page.dart';
import 'package:disaster_hackathon_app/pages/profile.dart';
import 'package:disaster_hackathon_app/pages/seek_resource.dart';
import 'package:disaster_hackathon_app/pages/send_resource.dart';
import 'package:disaster_hackathon_app/pages/signup_page.dart';
import 'package:disaster_hackathon_app/pages/track_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  final String url = dotenv.get('SUPABASE_URL');
  final String anonKey = dotenv.get('SUPABASE_ANON_KEY');

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );

  runApp(const MyApp());
  // FlutterNativeSplash.remove();
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Color(0xFF215283),
        scaffoldBackgroundColor: Colors.blue.shade100,
        // hintColor: Colors.white,
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/sendresource': (context) => SendResourcePage(),
        '/seekresource': (context) => SeekResourcePage(),
        '/notification': (context) => NotificationPage(),
        '/profile': (context) => ProfilePage(),
        '/mostrequestedresource': (context) => MostRequestedResourcesPage(),
        '/ongoingdisaster': (context) => OngoingDisasterPage(),
        '/trackresource': (context) => TrackResourcePage(),
        '/hotline': (context) => HotlinePage(),
        '/prepare': (context) => PreparePage(),
      },
    );
  }
}
