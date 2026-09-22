import 'package:flutter/material.dart';
import 'package:hushmind/Member 1/login.dart';

const Color background = Color(0xFF10120F);
const Color cardColor = Color(0xFF242820);
const Color accent = Color(0xFFC9FF73);
const Color white = Color(0xFFF5F7F1);
const Color muted = Color(0xFFB1B8AA);

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String name = "Name";
  final String email = "Name@aust.edu";

  void signOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your space",
                  style: TextStyle(
                    color: accent,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Make HushMind\nfeel like yours.",
                  style: TextStyle(color: white, fontSize: 34, height: 1.15),
                ),

                const SizedBox(height: 28),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Center(
                          child: Text(
                            name[0],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 18),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            email,
                            style: const TextStyle(color: muted, fontSize: 15),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Local demo mode",
                            style: TextStyle(color: accent, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  "Preferences",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      preference(
                        Icons.shield_outlined,
                        "Privacy & data",
                        "What is stored and where",
                      ),
                      const Divider(color: Colors.white12),
                      preference(
                        Icons.health_and_safety_outlined,
                        "Support & safety",
                        "Emergency and professional resources",
                      ),
                      const Divider(color: Colors.white12),
                      preference(Icons.translate, "Language", "English"),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => signOut(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      backgroundColor: cardColor,
                      side: const BorderSide(color: Colors.white12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: white),
                        SizedBox(width: 10),
                        Text(
                          "Sign out",
                          style: TextStyle(color: white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    "HushMind",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted, fontSize: 13),
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

Widget preference(IconData icon, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Icon(icon, color: white),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: white, fontSize: 16)),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: muted, fontSize: 13),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: muted),
      ],
    ),
  );
}
