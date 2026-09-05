import 'package:flutter/material.dart';
import 'package:hushmind/Member 1/login.dart';

import 'navigation_tab.dart';

const Color background = Color(0xFF10120F);
const Color surfaceSoft = Color(0xFF242820);
const Color accent = Color(0xFFC9FF73);
const Color accentSoft = Color(0xFF99C85E);
const Color sage = Color(0xFF6F8C5C);
const Color white = Color(0xFFF5F7F1);
const Color muted = Color(0xFFB1B8AA);

Widget dots(int activeIndex) {
  return Row(
    children: [
      Container(
        width: activeIndex == 0 ? 28 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: activeIndex == 0 ? accent : surfaceSoft,
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      const SizedBox(width: 8),

      Container(
        width: activeIndex == 1 ? 28 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: activeIndex == 1 ? accent : surfaceSoft,
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      const SizedBox(width: 8),

      Container(
        width: activeIndex == 2 ? 28 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: activeIndex == 2 ? accent : surfaceSoft,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ],
  );
}


// PAGE 1

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding_bg.png"),
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
                          builder: (context) => const LoginPage(),
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
                            Icons.favorite_border,
                            color: accent,
                            size: 32,
                          ),
                        ),

                        const SizedBox(height: 32),

                        const Text(
                          "A gentler daily rhythm",
                          style: TextStyle(
                            color: accent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "Pause. Notice.\nBegin again.",
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
                            "Check in with your emotions without judgement and build a clearer picture of what supports you.",
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

                dots(0),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 56,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingCalm(),
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
                          "Continue",
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

// PAGE 2

class OnboardingCalm extends StatelessWidget {
  const OnboardingCalm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding_bg.png"),
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
                          builder: (context) => const LoginPage(),
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

                          child: const Icon(Icons.air, color: accent, size: 32),
                        ),

                        const SizedBox(height: 32),

                        const Text(
                          "Tools for the moment",
                          style: TextStyle(
                            color: accent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "Find calm\nwhen you need it.",
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
                            "Use short breathing sessions, guided meditations, and grounding prompts designed for everyday stress.",
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

                dots(1),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 56,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingPrivacy(),
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
                          "Continue",
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

// PAGE 3

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
            image: AssetImage("assets/images/onboarding_bg.png"),
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
                          builder: (context) => const LoginPage(),
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
                          builder: (context) => const LoginPage(),
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
