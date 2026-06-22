import 'package:firebase_class_seventeen_batch/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/intro.png"),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0),
                  child: Center(
                    child: Text(
                      "You want\n Authentic, here\n you go!",
                      style: TextStyle(color: Colors.white, fontSize: 34),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: Text(
                    "Find it here, buy it now!",
                    style: TextStyle(color: Color(0xFFF2F2F2), fontSize: 14),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 58.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Colors.red,
                      ),
                      minimumSize: WidgetStatePropertyAll(Size(279, 55)),
                    ),

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
