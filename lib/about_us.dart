import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),

                      const SizedBox(width: 4),

                      const Text(
                        'About Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9FF73),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.spa,
                        color: Colors.black,
                        size: 42,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'HushMind',
                      style: TextStyle(
                        color: Color(0xFFC9FF73),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Center(
                    child: Text(
                      'A space to pause, reflect, and breathe.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFB1B8AA), fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 35),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232B22),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About HushMind',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'HushMind is a mental wellness app designed to '
                          'help you take a moment for yourself. It provides '
                          'a calm space for breathing exercises, meditation, '
                          'journaling, and wellness resources.',
                          style: TextStyle(
                            color: Color(0xFFB1B8AA),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232B22),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What you can do',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 16),

                        AboutItem(
                          icon: Icons.air,
                          text: 'Practice guided breathing',
                        ),

                        AboutItem(
                          icon: Icons.self_improvement,
                          text: 'Listen to guided meditation',
                        ),

                        AboutItem(
                          icon: Icons.edit_note,
                          text: 'Reflect through journaling',
                        ),

                        AboutItem(
                          icon: Icons.menu_book,
                          text: 'Explore wellness resources',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232B22),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Team',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 18),

                        TeamMember(
                          name: 'Md. Raiyan Hussain Choudhury',
                          id: '00724205101067',
                        ),

                        TeamMember(name: 'Samiya Akhter', id: '00724205101081'),

                        TeamMember(
                          name: 'Maisha Islam Moumita',
                          id: '00724205101088',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'Made with care ♡',
                          style: TextStyle(
                            color: Color(0xFFC9FF73),
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          'HushMind • Version 1.0.0',
                          style: TextStyle(
                            color: Color(0xFFB1B8AA),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const AboutItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const SizedBox(width: 2),

          Icon(icon, color: const Color(0xFFC9FF73), size: 22),

          const SizedBox(width: 12),

          Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class TeamMember extends StatelessWidget {
  final String name;
  final String id;

  const TeamMember({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFC9FF73),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person, color: Colors.black, size: 22),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                id,
                style: const TextStyle(color: Color(0xFFB1B8AA), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
