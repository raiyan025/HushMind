import 'package:flutter/material.dart';
import 'breathe_screen.dart';
import 'meditation_session.dart';
import 'support.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

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

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WELLNESS LIBRARY',
                    style: TextStyle(
                      color: Color(0xFFD0FD38),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Choose what you\nneed today.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Short, approachable practices for real-life moments.',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      category('All', true),
                      category('Calm', false),
                      category('Sleep', false),
                      category('Focus', false),
                      category('Morning', false),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 44) / 2,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BreatheScreen(),
                              ),
                            );
                          },
                          child: optionCard(
                            Icons.air,
                            'Guided\nbreathing',
                            false,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 44) / 2,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SupportPage(),
                              ),
                            );
                          },
                          child: optionCard(Icons.add, 'Find\nsupport', true),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Meditation sessions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeditationPlayerScreen(
                            title: 'Quiet the noise',
                            subtitle: 'A gentle reset for an active mind',
                            audioPath: 'audio/quiet_the_noise.mp3',
                            icon: Icons.grain,
                          ),
                        ),
                      );
                    },
                    child: meditationCard(
                      Icons.grain,
                      'Quiet the noise',
                      '5 min • Calm',
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeditationPlayerScreen(
                            title: 'Deep sleep release',
                            subtitle: 'Let your mind slow down for sleep',
                            audioPath: 'audio/deep_sleep_release.mp3',
                            icon: Icons.nightlight_round,
                          ),
                        ),
                      );
                    },
                    child: meditationCard(
                      Icons.nightlight_round,
                      'Deep sleep release',
                      '5 min • Sleep',
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeditationPlayerScreen(
                            title: 'Steady focus',
                            subtitle: 'Settle your mind and find your focus',
                            audioPath: 'audio/steady_focus.mp3',
                            icon: Icons.adjust,
                          ),
                        ),
                      );
                    },
                    child: meditationCard(
                      Icons.adjust,
                      'Steady focus',
                      '5 min • Focus',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget category(String text, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFD0FD38) : const Color(0xFF232B22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget optionCard(IconData icon, String text, bool green) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: green ? const Color(0xFFD0FD38) : const Color(0xFF232B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: green ? Colors.black : const Color(0xFFD0FD38)),

          Text(
            text,
            style: TextStyle(
              color: green ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget meditationCard(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF232B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF98CA53),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.black),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),

          const Spacer(),

          const Icon(
            Icons.play_circle_fill,
            color: Color(0xFFD0FD38),
            size: 36,
          ),
        ],
      ),
    );
  }
}
