import 'package:flutter/material.dart';

import 'package:hushmind/home_screen.dart';
import 'package:hushmind/wellness_library_screen_full.dart';
import 'package:hushmind/journal.dart';
import 'package:hushmind/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final pages = [
    const HomeScreen(),
    const WellnessLibraryScreen(),
    const JournalPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
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
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1D18),
        border: Border(
          top: BorderSide(
            color: Color(0xFF2A2D27),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navigationItem(Icons.home_rounded, 0),
            navigationItem(Icons.grid_view_rounded, 1),
            navigationItem(Icons.edit_note_rounded, 2),
            navigationItem(Icons.person_rounded, 3),
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
                color: selected
                    ? const Color(0xFFC9FF73)
                    : Colors.transparent,
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