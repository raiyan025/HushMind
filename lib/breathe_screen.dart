import 'dart:async';
import 'package:flutter/material.dart';

class BreatheScreen extends StatefulWidget {
  const BreatheScreen({super.key});

  @override
  State<BreatheScreen> createState() => _BreatheScreenState();
}

class _BreatheScreenState extends State<BreatheScreen> {
  Timer? timer;

  int secondsLeft = 120;
  bool isRunning = true;

  String phase = 'Breathe in';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isRunning) return;

      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;

          int cycle = (120 - secondsLeft) % 12;

          if (cycle < 4) {
            phase = 'Breathe in';
          } else if (cycle < 8) {
            phase = 'Hold';
          } else {
            phase = 'Breathe out';
          }
        } else {
          timer.cancel();
          phase = 'Done';
          isRunning = false;
        }
      });
    });
  }

  void toggleTimer() {
    setState(() {
      isRunning = !isRunning;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get time {
    int minutes = secondsLeft ~/ 60;
    int seconds = secondsLeft % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

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
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        '2-MINUTE RESET',
                        style: TextStyle(
                          color: Color(0xFFD0FD38),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Breathe with\nthe light.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Inhale for 4 • hold for 4 • exhale for 4',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),

                  const SizedBox(height: 40),

                  Center(
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: const Color(0xFF232B22),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD0FD38),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            phase,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            time,
                            style: const TextStyle(
                              color: Color(0xFFD0FD38),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  Container(
                    padding: const EdgeInsets.all(16),
                    color: const Color(0xFF232B22),
                    child: const Row(
                      children: [
                        Icon(Icons.graphic_eq, color: Color(0xFFD0FD38)),
                        SizedBox(width: 12),
                        Text(
                          'Soft rain audio',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down, color: Colors.white54),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: toggleTimer,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD0FD38),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isRunning ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          color: const Color(0xFF232B22),
                          child: const Text(
                            'End session',
                            style: TextStyle(
                              color: Colors.white,
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
        ],
      ),
    );
  }
}
