import 'package:disaster_hackathon_app/main.dart';
import 'package:disaster_hackathon_app/services/storage_service.dart';
import 'package:disaster_hackathon_app/utils/storage_constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthListenerWidget extends StatefulWidget {
  const AuthListenerWidget({super.key});

  @override
  AuthListenerWidgetState createState() => AuthListenerWidgetState();
}

class AuthListenerWidgetState extends State<AuthListenerWidget> {
  @override
  void initState() {
    super.initState();
    listenAuthChanges();
  }

  void listenAuthChanges() {
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        StorageService.storage.write(StorageConstants.authKey, data.session);
        // navigateToHome();
      } else if (data.event == AuthChangeEvent.signedOut) {
        StorageService.storage.remove(StorageConstants.authKey);
        navigateToLogin();
      } else if (data.event == AuthChangeEvent.tokenRefreshed) {
        StorageService.storage.remove(StorageConstants.authKey);
        navigateToLogin();
      }
    });
  }

  void navigateToHome() {
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (Route<dynamic> route) => false,
      );
    }
  }

  void navigateToLogin() {
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/user_login',
        ModalRoute.withName('/'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Replace with the actual widget tree
  }
}
