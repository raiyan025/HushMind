import 'package:flutter/material.dart';
import 'package:hushmind/Member 1/login.dart';
import 'onboarding1.dart';

class OnboardingPrivacy extends StatelessWidget {
  const OnboardingPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,

                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: accent,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Container(
                          height: 84,
                          width: 84,

                          decoration: BoxDecoration(
                            color: accentSoft.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: accent.withOpacity(0.4)),
                          ),

                          child: const Icon(
                            Icons.lock_outline,
                            color: accent,
                            size: 32,
                          ),
                        ),

                        const SizedBox(height: 32),

                        const Text(
                          "Your words stay yours",
                          style: TextStyle(
                            color: accent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "A private space\nto reflect.",
                          style: TextStyle(
                            color: white,
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                            height: 1.15,
                            letterSpacing: -0.4,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const SizedBox(
                          width: 320,

                          child: Text(
                            "Keep a personal journal and review emotional patterns. HushMind supports wellness; it does not diagnose.",
                            style: TextStyle(
                              color: muted,
                              fontSize: 15.5,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                dots(2),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 56,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(Icons.north_east, color: background, size: 18),

                        SizedBox(width: 8),

                        Text(
                          "Enter HushMind",
                          style: TextStyle(
                            color: background,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
