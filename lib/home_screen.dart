import 'package:flutter/material.dart';
import 'package:hushmind/navigation_bar.dart';
import 'package:hushmind/breathe_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                // Header
                Row(
                  children: [
                    Container(
                      color: const Color(0xFFD0FD38),
                      padding: const EdgeInsets.all(12.0),
                      child: const Icon(
                        Icons.auto_awesome_sharp,
                        color: Colors.black,
                        size: 20,
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

                const SizedBox(height: 16),
                // Today's Check-in
                Container(
                  color: const Color(0xFF232B22),
                  padding: const EdgeInsets.all(16.0),
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
                    // Breathe Card -> Goes to BreatheScreen
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BreatheScreen(),
                          ),
                        );
                      },
                      child: Container(
                        color: const Color(0xFF232B22),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        child: const Column(
                          children: [
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
                    Container(
                      color: const Color(0xFF232B22),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      child: const Column(
                        children: [
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
                    Container(
                      color: const Color(0xFF232B22),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      child: const Column(
                        children: [
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