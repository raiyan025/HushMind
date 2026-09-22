import 'package:flutter/material.dart';

import 'package:hushmind/Member%203/home_screen.dart';
import 'package:hushmind/Member 3/wellness_library_screen_full.dart';
import 'package:hushmind/Member%202/journal.dart';
import 'package:hushmind/community_forum.dart';
import 'package:hushmind/insights.dart';
import 'package:hushmind/Member%202/profile.dart';
import 'package:hushmind/Member 3/two_minute_reset_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),

      WellnessLibraryScreen(
        onNavigateToReset: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TwoMinuteResetScreen(),
            ),
          );
        },
      ),

      const JournalPage(),
      const ForumPage(),
      const Insights(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF4A2A2A),
        child: const Icon(Icons.call, color: Colors.white),
      ),

      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const names = [
    'Home',
    'Explore',
    'Journal',
    'Forum',
    'Insights',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1D18),
        border: Border(top: BorderSide(color: Color(0xFF2A2D27), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navigationItem(Icons.home_rounded, 0),
            navigationItem(Icons.grid_view_rounded, 1),
            navigationItem(Icons.edit_note_rounded, 2),
            navigationItem(Icons.forum_rounded, 3),
            navigationItem(Icons.insights_rounded, 4),
            navigationItem(Icons.person_rounded, 5),
          ],
        ),
      ),
    );
  }

  Widget navigationItem(IconData icon, int index) {
    final bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 58,
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFC9FF73) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: selected ? Colors.black : Colors.white70,
                size: 21,
              ),
            ),
            if (selected)
              Text(
                names[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
