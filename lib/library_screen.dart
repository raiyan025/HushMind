import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- PART 1: Top Header Section ---
                const Text(
                  "WELLNESS LIBRARY",
                  style: TextStyle(
                    color: Color(0xFFD0FD38),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Choose what you\nneed today.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                // --- PART 2: Subtitle & Horizontal Category Chips ---
                const SizedBox(height: 16),
                const Text(
                  "Short, approachable practices for real-life moments.",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Active Chip (Neon Yellow)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD0FD38),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "All",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Inactive Chips (Dark Olive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232B22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Calm",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232B22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Sleep",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232B22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Focus",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232B22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Morning",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- PART 3: Top Feature Cards (Guided breathing & Find support) ---
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Guided Breathing Card
                    Expanded(
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232B22),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.air, color: Color(0xFFD0FD38), size: 24),
                            Text(
                              "Guided\nbreathing",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Find Support Card (Neon Yellow Background)
                    Expanded(
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD0FD38),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.add, color: Colors.black, size: 24),
                            Text(
                              "Find\nsupport",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // --- PART 4: Meditation Sessions List ---
                const SizedBox(height: 24),
                const Text(
                  "Meditation sessions",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Session Item 1: Quiet the noise
                Container(
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
                        child: const Icon(Icons.grain, color: Colors.black, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quiet the noise",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "5 min • Calm",
                            style: TextStyle(color: Colors.white54, fontSize: 11),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.play_circle_fill, color: Color(0xFFD0FD38), size: 36),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Session Item 2: Deep sleep release
                Container(
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
                        child: const Icon(Icons.nightlight_round, color: Colors.black, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deep sleep release",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "12 min • Sleep",
                            style: TextStyle(color: Colors.white54, fontSize: 11),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.play_circle_fill, color: Color(0xFFD0FD38), size: 36),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Session Item 3: Steady focus
                Container(
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
                        child: const Icon(Icons.adjust, color: Colors.black, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Steady focus",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "8 min • Focus",
                            style: TextStyle(color: Colors.white54, fontSize: 11),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.play_circle_fill, color: Color(0xFFD0FD38), size: 36),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- PART 5: Bottom Navigation Bar ---
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B221B),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context); // Go back to Home
                        },
                        child: const Icon(Icons.home_outlined, color: Colors.white54, size: 22),
                      ),
                      // Active Bottom Tab
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD0FD38),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add_box_outlined, color: Colors.black, size: 20),
                      ),
                      const Icon(Icons.edit_note, color: Colors.white54, size: 22),
                      const Icon(Icons.bolt, color: Colors.white54, size: 22),
                      const Icon(Icons.adjust, color: Colors.white54, size: 22),
                    ],
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