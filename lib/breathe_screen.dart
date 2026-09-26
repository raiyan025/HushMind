import 'package:flutter/material.dart';

class BreatheScreen extends StatelessWidget {
  const BreatheScreen({super.key});

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
                // --- STEP 1: Top Bar (Back Button + Header Text) ---
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context); // Back to HomeScreen
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: const Color(0xFF232B22),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "2-MINUTE RESET",
                      style: TextStyle(
                        color: Color(0xFFD0FD38),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // --- STEP 2: Main Title Section ---
                const SizedBox(height: 24),
                const Text(
                  "Breathe with\nthe light.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                // --- STEP 3: Subtitle Instruction ---
                const SizedBox(height: 12),
                const Text(
                  "Inhale for 4 • hold for 4 • exhale for 4",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),

                // --- STEP 4: Main Circle Indicator ---
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF232B22),
                      border: Border.all(
                        color: const Color(0xFFD0FD38).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Breathe in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "01:42",
                          style: TextStyle(
                            color: Color(0xFFD0FD38),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- STEP 5: Bottom Audio Controls & End Session ---
                const SizedBox(height: 50),

                // Ambient Sound Selection Card
                Container(
                  color: const Color(0xFF232B22),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.graphic_eq,
                        color: Color(0xFFD0FD38),
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Soft rain audio",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Play/Pause Button & End Session Text Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Play / Pause Circle Button
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD0FD38),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.pause,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),

                    // End Session Button
                    InkWell(
                      onTap: () {
                        Navigator.pop(context); // Close session & return
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        color: const Color(0xFF232B22),
                        child: const Text(
                          "End session",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}