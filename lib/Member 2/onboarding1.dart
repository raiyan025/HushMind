import 'package:flutter/material.dart';
import 'package:hushmind/Member 1/login.dart';
import 'package:hushmind/Member%202/onboarding2.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Color(0xFF99C85E), fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 270),
              Row(
                children: [
                  const SizedBox(width: 32),
                  Icon(
                    Icons.favorite_border,
                    color: Color(0xFFC9FF73),
                    size: 50,
                  ),
                ],
              ),
              const SizedBox(height: 35),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'A gentler daily rhythm',
                    style: TextStyle(
                      color: Color(0xFF99C85E),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Pause. Notice.\nBegin again.',
                    style: TextStyle(
                      color: Color(0xFFF5F7F1),
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Check in with your emotions without\n'
                    'judgement and build a clearer picture of\n'
                    'what supports you.',
                    style: TextStyle(color: Color(0xFFB1B8AA), fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingCalm(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC9FF73),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(350, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),

                    child: const Text('Continue'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

