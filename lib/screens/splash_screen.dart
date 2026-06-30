import 'package:firebase_class_seventeen_batch/screens/introduction_page.dart';
import 'package:firebase_class_seventeen_batch/screens/product_screen.dart';
import 'package:firebase_class_seventeen_batch/screens/profile_screen.dart';
import 'package:firebase_class_seventeen_batch/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final users = await _firebaseAuthServices.authStateChanges.first;

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            users != null ? ProductScreen() : const IntroductionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/splash.png",
          fit: BoxFit.contain,
          height: 100,
          width: 275,
        ),
      ),
    );
  }
}
