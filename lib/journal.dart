import 'package:flutter/material.dart';
import 'package:hushmind/journal_editor.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

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
              const SizedBox(height: 60),
              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Private Journal',
                    style: TextStyle(
                      color: Color(0xFFC9FF73),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 170),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JournalEditor(),
                        ),
                      );
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFFC9FF73),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(50, 50),
                    ),
                    icon: const Icon(Icons.add, size: 25),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Put the feeling\n'
                    'somewhere safe.',
                    style: TextStyle(
                      color: Color(0xFFF5F7F1),
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Write freely. You never have to share it.',
                    style: TextStyle(color: Color(0xFFB1B8AA), fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JournalEditor(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF242820),
                  foregroundColor: Color(0xFFF5F7F1),
                  minimumSize: const Size(380, 120),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TODAY'S PROMPT",
                      style: TextStyle(
                        color: Color(0xFF99C85E),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'What would feel\n'
                      'supportive today?',
                      style: TextStyle(color: Color(0xFFF5F7F1), fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 10),
                  const Text(
                    'Recent Reflections',
                    style: TextStyle(color: Color(0xFFF5F7F1), fontSize: 18,fontWeight: FontWeight.bold),
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