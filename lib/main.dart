import 'package:flutter/material.dart';
import 'breathe_screen.dart'; // 2nd screen (Breathe) import
import 'library_screen.dart'; // 3rd screen (Library) import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// =========================================================
// FIRST SCREEN: HomeScreen
// =========================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Pure black background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- STEP 1: Top Header Section ---
                Row(
                  children: [
                    ColoredBox(
                      color: const Color(0xFFD0FD38), // Neon Yellow Icon Box
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.auto_awesome_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good evening, Alex",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Make a little room for yourself.",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 22,
                    ),
                  ],
                ),

                // --- STEP 2: TODAY'S CHECK-IN Card ---
                const SizedBox(height: 16),
                ColoredBox(
                  color: const Color(0xFF232B22), // Dark Olive Green Card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
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
                          "How is your inner\nweather right now?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "There is no right answer—just notice what is here.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD0FD38),
                          ),
                          child: const Text(
                            "Check in now",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- STEP 3: Quick Reset Section ---
                const SizedBox(height: 20),
                const Text(
                  "Quick reset",
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
                    // Breathe Card (Goes to BreatheScreen)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BreatheScreen(),
                          ),
                        );
                      },
                      child: ColoredBox(
                        color: const Color(0xFF232B22),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          child: Column(
                            children: const [
                              Icon(
                                Icons.air,
                                color: Color(0xFFD0FD38),
                                size: 22,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Breathe",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "2 min",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Meditate Card
                    ColoredBox(
                      color: const Color(0xFF232B22),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.trip_origin,
                              color: Color(0xFFD0FD38),
                              size: 22,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Meditate",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "5 min",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Reflect Card
                    ColoredBox(
                      color: const Color(0xFF232B22),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.edit,
                              color: Color(0xFFD0FD38),
                              size: 22,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Reflect",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Journal",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // --- STEP 4: For Your Evening Section ---
                const SizedBox(height: 20),
                const Text(
                  "For your evening",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ColoredBox(
                  color: const Color(0xFF232B22),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ColoredBox(
                          color: const Color(0xFF98CA53),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.nightlight_round,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deep sleep release",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "12 min • Sleep",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
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
                  ),
                ),

                const SizedBox(height: 20),

                // --- STEP 5: Bottom Navigation Bar ---
                ColoredBox(
                  color: const Color(0xFF1B221B),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.home,
                          color: Color(0xFFD0FD38),
                          size: 24,
                        ),

                        // Library Screen Navigation (+)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LibraryScreen(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add_box_outlined,
                            color: Colors.white54,
                            size: 24,
                          ),
                        ),

                        const Icon(
                          Icons.edit_note,
                          color: Colors.white54,
                          size: 24,
                        ),
                        const Icon(
                          Icons.bolt,
                          color: Colors.white54,
                          size: 24,
                        ),
                        const Icon(
                          Icons.adjust,
                          color: Colors.white54,
                          size: 24,
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