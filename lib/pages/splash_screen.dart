import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart'; // Make sure this is imported
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the animation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Initialize confetti controller
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    // Start the animation
    _controller.forward();

    // Start the confetti
    _confettiController.play();

    // Navigate to the Home Page after the animation
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => HomeScreen());
    });
  }

  @override
  void dispose() {
    // Dispose of the controllers
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/splash_bg.jpeg', // Replace with your campus background image asset
            fit: BoxFit.cover,
          ),
          // Dark overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color.fromARGB(200, 0, 0, 0), // Adding a slight dark overlay
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    'assets/images/logo.jpeg', // Replace with your logo asset
                    height: 100,
                    width: 100,
                  ),
                ),
                // Animated Text
                FadeTransition(
                  opacity: _animation,
                  child: const Text(
                    'GC Gallery: Wollo University Class of 2024',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Confetti widget
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: 3.14, // radians - left
                  particleDrag: 0.05,
                  emissionFrequency: 0.05,
                  numberOfParticles: 30,
                  gravity: 0.1,
                  colors: const [
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                    Colors.yellow,
                    Colors.orange,
                    Colors.pink,
                    Colors.purple,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
