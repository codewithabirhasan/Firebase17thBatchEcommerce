import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class_seventeen_batch/screens/profile_screen.dart';
import 'package:firebase_class_seventeen_batch/screens/signin_screen.dart';
import 'package:firebase_class_seventeen_batch/services/firebase_auth_services.dart';
import 'package:firebase_class_seventeen_batch/services/profile_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailcontroler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  bool isLoading = false;

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  final ProfileService profileService = ProfileService();

  Future register() async {
    setState(() {
      isLoading = true;
    });
    String email = emailcontroler.text;
    String password = passwordControler.text;
    String confirmpassword = confirmpasswordController.text;

    if (password != confirmpassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password do not match")));

      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      await firebaseAuthServices.register(email, password);

      // signup er por uid FirebaseAuth.currentUser theke neya safe
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) {
        throw Exception('User ID not found after registration');
      }

      await profileService.createInitialprofile(uid, email);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration Successfully")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 58.0, left: 12),
              child: Text(
                "Create an\naccount!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: emailcontroler,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  fillColor: Color(0xFFF3F3F3),
                  filled: true,
                  hintText: "Username or Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: passwordControler,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.security),
                  fillColor: Color(0xFFF3F3F3),
                  filled: true,
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: confirmpasswordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.security),
                  fillColor: Color(0xFFF3F3F3),
                  filled: true,
                  hintText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 30),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 58.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            Colors.red,
                          ),
                          minimumSize: WidgetStatePropertyAll(Size(317, 55)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Custom radius
                            ),
                          ),
                        ),

                        onPressed: () {
                          register();
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "I Already Have an Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login?",
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
