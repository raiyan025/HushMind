import 'package:flutter/material.dart';
import 'package:hushmind/journal_editor.dart';

const Color background = Color(0xFF10120F);
const Color cardColor = Color(0xFF242820);
const Color accent = Color(0xFFC9FF73);
const Color white = Color(0xFFF5F7F1);
const Color muted = Color(0xFFB1B8AA);

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  void startWriting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WriteEntryPage()),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Private journal",
                      style: TextStyle(
                        color: accent,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    GestureDetector(
                      onTap: () => startWriting(context),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  "Put the feeling\nsomewhere safe.",
                  style: TextStyle(color: white, fontSize: 34, height: 1.15),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Write freely. You never have to share it.",
                  style: TextStyle(color: muted, fontSize: 16),
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
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TODAY'S PROMPT",
                              style: TextStyle(
                                color: accent,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              "What would feel\nsupportive today?",
                              style: TextStyle(
                                color: white,
                                fontSize: 24,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () => startWriting(context),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.north_east,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                const Text(
                  "Recent reflections",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 16),


                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    children: [
                      const Icon(Icons.edit_note, color: accent, size: 44),

                      const SizedBox(height: 20),

                      const Text(
                        "Your journal is ready.",
                        style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Begin with one honest sentence. That is enough.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: muted, fontSize: 15),
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: () => startWriting(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                        ),
                        child: const Text(
                          "Write first entry",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Center(
                  child: Text(
                    "Stored locally for now",
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
