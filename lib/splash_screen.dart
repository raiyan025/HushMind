import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hushmind/onboarding1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    const green = Color(0xFFC7F464);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: green,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dot(green),
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

  Widget _dot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
