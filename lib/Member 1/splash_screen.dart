import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hushmind/Member%202/onboarding1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate initial loading or navigation delay
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Light status bar icons for dark background
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    const primaryGreen = Color(0xFFC7F464);
    const darkBackground = Color(0xFF0D120B);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Ambient blurred glow spots for the background
          Positioned(
            top: -60,
            right: -40,
            child: _glowSpot(const Color(0xFF384A1E), 260),
          ),
          Positioned(
            bottom: 80,
            left: -50,
            child: _glowSpot(const Color(0xFF1E2812), 220),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                // App Icon Container
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.spa_sharp,
                      color: Color(0xFF1B2313),
                      size: 38,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // App Title
                const Text(
                  'HushMind',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Tagline
                const Text(
                  'A safe space for mental wellness',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9EABA0),
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const Spacer(),

                // Bottom Page / Loading Indicator Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dot(primaryGreen),
                    const SizedBox(width: 8),
                    _dot(const Color(0xFF4A554A)),
                    const SizedBox(width: 8),
                    _dot(const Color(0xFF4A554A)),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Soft glow circular blur widget
  Widget _glowSpot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.55),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  // Indicator dot helper
  Widget _dot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}