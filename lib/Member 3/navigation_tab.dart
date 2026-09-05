import 'package:flutter/material.dart';

import 'package:hushmind/Member 1/home.dart';
import 'package:hushmind/Member 3/wellness_library.dart';
import 'package:hushmind/Member 2/journal.dart';
import 'package:hushmind/community_forum.dart';
import 'package:hushmind/Member 2/insights.dart';
import 'package:hushmind/Member 3/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final pages = [
    const MyHomePage(title: ''),
    const ExplorePage(),
    const JournalPage(),
    const ForumPage(),
    const Insights(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],

          const Positioned(right: 16, bottom: 16, child: TrustedContactPill()),
        ],
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

class TrustedContactPill extends StatelessWidget {
  const TrustedContactPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF4A2A2A).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.call, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            "Trusted contact",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1D18),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navigationItem(Icons.home_outlined, 0),
            navigationItem(Icons.add_box_outlined, 1),
            navigationItem(Icons.edit_note_outlined, 2),
            navigationItem(Icons.forum_outlined, 3),
            navigationItem(Icons.insights_outlined, 4),
            navigationItem(Icons.person_outline, 5),
          ],
        ),
      ),
    );
  }

  Widget navigationItem(IconData icon, int index) {
    final bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFC9FF73) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: selected ? Colors.black : Colors.white70,
          size: 22,
        ),
      ),
    );
  }
}
