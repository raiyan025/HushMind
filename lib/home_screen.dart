import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hushmind/breathe_screen.dart';
import 'package:hushmind/meditation_session.dart';
import 'package:hushmind/journal_editor.dart';
import 'package:hushmind/private_check_in_screen.dart';
import 'package:hushmind/support.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final displayName = (user?.displayName ?? '').trim();
    final name = displayName.isNotEmpty ? displayName : 'Friend';

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD0FD38),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.spa,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good evening, $name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            'Make a little room for yourself.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SupportPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.health_and_safety,
                          color: Color(0xFFD0FD38),
                          size: 35,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    color: const Color(0xFF232B22),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TODAY'S CHECK-IN",
                              style: TextStyle(
                                color: Color(0xFFD0FD38),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Icon(
                              Icons.favorite,
                              color: Color(0xFFD0FD38),
                              size: 16,
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'How is your inner\nweather right now?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'There is no right answer—just notice what is here.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),

                        const SizedBox(height: 16),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MoodCheckInPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD0FD38),
                          ),
                          child: const Text(
                            'Check in now',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Quick reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      quickReset(
                        context,
                        Icons.air,
                        'Breathe',
                        '2 min',
                        const BreatheScreen(),
                      ),

                      quickReset(
                        context,
                        Icons.trip_origin,
                        'Meditate',
                        '5 min',
                        const MeditationPlayerScreen(
                          title: 'Quiet the noise',
                          subtitle: 'A gentle reset for an active mind',
                          audioPath: 'audio/quiet_the_noise.mp3',
                          icon: Icons.grain,
                        ),
                      ),

                      quickReset(
                        context,
                        Icons.edit,
                        'Reflect',
                        'Journal',
                        const JournalEditor(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget quickReset(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget screen,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        color: const Color(0xFF232B22),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFD0FD38), size: 22),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              style: const TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
