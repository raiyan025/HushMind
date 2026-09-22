import 'package:flutter/material.dart';

class JournalEditor extends StatelessWidget {
  const JournalEditor({super.key});

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
              const SizedBox(height: 50),

              Row(
                children: [
                  const SizedBox(width: 25),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(50, 50),
                    ),
                    icon: const Icon(Icons.close, size: 28),
                  ),
                  const SizedBox(width: 250),
                  const Text(
                    '✓  Save',
                    style: TextStyle(
                      color: Color(0xFFC9FF73),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              Row(
                children: [
                  const SizedBox(width: 25),
                  const Text(
                    'What would feel supportive today?',
                    style: TextStyle(color: Color(0xFFF5F7F1), fontSize: 15),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    "Today's reflection",
                    style: TextStyle(color: Color(0xFFF5F7F1), fontSize: 30),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              TextField(
                style: const TextStyle(color: Color(0xFFF5F7F1), fontSize: 18),
                decoration: const InputDecoration(
                  hintText: 'Write without editing yourself...',
                ),
              ),

              const SizedBox(height: 500),
              Row(
                children: [
                  const SizedBox(width: 30),
                  const Icon(
                    Icons.lock_outline,
                    color: Color(0xFFB1B8AA),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Private by design',
                    style: TextStyle(color: Color(0xFFB1B8AA), fontSize: 16),
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
