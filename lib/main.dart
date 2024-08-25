import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:disaster_hackathon_app/pages/user_selection_page.dart';
import 'package:disaster_hackathon_app/pages/user_login_page.dart';
import 'package:disaster_hackathon_app/pages/user_signup_page.dart';
import 'package:disaster_hackathon_app/pages/user_reset_password_page.dart';
import 'package:disaster_hackathon_app/pages/user_forgot_password_page.dart';
import 'package:disaster_hackathon_app/pages/user_otp_verification_page.dart';
import 'package:disaster_hackathon_app/pages/volunteer_login_page.dart';
import 'package:disaster_hackathon_app/pages/volunteer_signup_page.dart';
import 'package:disaster_hackathon_app/pages/volunteer_reset_password_page.dart';
import 'package:disaster_hackathon_app/pages/volunteer_forgot_password_page.dart';
import 'package:disaster_hackathon_app/pages/volunteer_otp_verification_page.dart';
import 'package:disaster_hackathon_app/pages/home_page.dart';
import 'package:disaster_hackathon_app/pages/send_resource.dart';
import 'package:disaster_hackathon_app/pages/seek_resource.dart';
import 'package:disaster_hackathon_app/pages/notification.dart';
import 'package:disaster_hackathon_app/pages/profile.dart';
import 'package:disaster_hackathon_app/pages/most_requested_resource.dart';
import 'package:disaster_hackathon_app/pages/ongoing_disaster.dart';
import 'package:disaster_hackathon_app/pages/track_resource.dart';
import 'package:disaster_hackathon_app/pages/hotline.dart';
import 'package:disaster_hackathon_app/pages/prepare_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  final String url = dotenv.get('SUPABASE_URL');
  final String anonKey = dotenv.get('SUPABASE_ANON_KEY');

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );

  runApp(const MyApp());
  FlutterNativeSplash.remove();
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
        scaffoldBackgroundColor: Colors.blue.shade100,
      ),
      home: UserSelectionPage(), // Set the initial route to UserSelectionPage
      routes: {
        '/user_login': (context) => UserLoginPage(),
        '/user_signup': (context) => UserSignUpPage(),
        '/user_reset_password': (context) => UserResetPasswordPage(),
        '/user_forgotpassword': (context) => UserForgotPasswordPage(),
        '/user_otp': (context) => UserOTPVerificationPage(),
        '/volunteer_login': (context) => VolunteerLoginPage(),
        '/volunteer_signup': (context) => VolunteerSignupPage(),
        '/volunteer_reset_password': (context) => VolunteerResetPasswordPage(),
        '/volunteer_forgotpassword': (context) => VolunteerForgotPasswordPage(),
        '/volunteer_otp': (context) => VolunteerOTPVerificationPage(),
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
