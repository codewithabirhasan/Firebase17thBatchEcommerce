import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class_seventeen_batch/screens/profile_screen.dart';
import 'package:firebase_class_seventeen_batch/screens/sign_up_screen.dart';
import 'package:firebase_class_seventeen_batch/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;

  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  Future login() async {
    setState(() {
      isloading = true;
    });

    try {
      await firebaseAuthServices.login(
        emailControler.text,
        passwordController.text,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successfully")));

      setState(() {
        isloading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } on FirebaseAuthException catch (exception) {
      String message;

      switch (exception.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;

        case 'wrong-password':
          message = 'Incorrect password.';
          break;

        case 'invalid-email':
          message = 'Invalid email address.';
          break;

        case 'invalid-credential':
          message = 'Invalid email or password.';
          break;

        case 'user-disabled':
          message = 'This account has been disabled.';
          break;

        case 'too-many-requests':
          message = 'Too many login attempts. Try again later.';
          break;

        case 'network-request-failed':
          message = 'No internet connection.';
          break;

        default:
          message = exception.message ?? 'Login failed.';
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }

      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text("${exception.message}")));
    } finally {
      if (mounted) {
        setState(() {
          isloading = false;
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
                "Welcome\nBack!",
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
                controller: emailControler,
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
                controller: passwordController,
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
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Forgot password?", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),

            SizedBox(height: 30),

            isloading
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
                          login();
                        },
                        child: Text(
                          "Login",
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
                    "Create An Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      "Sign Up?",
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
