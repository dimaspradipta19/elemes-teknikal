import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technical_elemes/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreenTimer() async {
    await Future.delayed(const Duration(seconds: 4));

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return const Homescreen();
      },
    ), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    splashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.amber[200]),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Movie Apps",
                  style: GoogleFonts.quicksand(
                      fontSize: 50.0, color: Colors.black),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const CircularProgressIndicator.adaptive()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
