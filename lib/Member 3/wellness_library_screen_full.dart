import 'dart:math';
import 'package:flutter/material.dart';
import 'audio_player_screen.dart';

// Custom Painter for Dashed/Dotted Circle Icon (Quiet the noise)
class DashedCirclePainter extends CustomPainter {
  final Color color;
  const DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.6;
    const dashCount = 12;
    const dashArcLength = (2 * pi / dashCount) * 0.55;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (2 * pi / dashCount) * i;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashArcLength,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) =>
      oldDelegate.color != color;
}

// Custom Painter for Concentric Circles Target Icon (Steady focus)
class ConcentricTargetPainter extends CustomPainter {
  final Color color;
  const ConcentricTargetPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Outer circle
    canvas.drawCircle(center, size.width / 2.6, strokePaint);
    // Inner target dot
    canvas.drawCircle(center, size.width / 7.5, fillPaint);
  }

  @override
  bool shouldRepaint(covariant ConcentricTargetPainter oldDelegate) =>
      oldDelegate.color != color;
}

// Custom Painter for Upward Arrows Icon (Guided breathing)
class UpwardArrowsPainter extends CustomPainter {
  final Color color;
  const UpwardArrowsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    // Central stem
    path.moveTo(size.width / 2, size.height * 0.82);
    path.lineTo(size.width / 2, size.height * 0.18);

    // Top arrow head
    path.moveTo(size.width * 0.28, size.height * 0.40);
    path.lineTo(size.width / 2, size.height * 0.18);
    path.lineTo(size.width * 0.72, size.height * 0.40);

    // Lower arrow chevron
    path.moveTo(size.width * 0.32, size.height * 0.60);
    path.lineTo(size.width / 2, size.height * 0.42);
    path.lineTo(size.width * 0.68, size.height * 0.60);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant UpwardArrowsPainter oldDelegate) =>
      oldDelegate.color != color;
}

class WellnessLibraryScreen extends StatefulWidget {
  final VoidCallback onNavigateToReset;

  const WellnessLibraryScreen({
    super.key,
    required this.onNavigateToReset,
  });

  @override
  State<WellnessLibraryScreen> createState() => _WellnessLibraryScreenState();
}

class _WellnessLibraryScreenState extends State<WellnessLibraryScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Calm',
    'Sleep',
    'Focus',
    'Morning',
  ];

  final List<Map<String, dynamic>> _meditationSessions = [
    {
      'title': 'Quiet the noise',
      'duration': '5 min',
      'durationSeconds': 300,
      'category': 'Calm',
      'subtitle': 'Find tranquility amidst daily noise',
      'iconType': 'dashed_circle',
    },
    {
      'title': 'Deep sleep release',
      'duration': '12 min',
      'durationSeconds': 720,
      'category': 'Sleep',
      'subtitle': 'Slow down and prepare the body for rest',
      'iconType': 'crescent_moon',
    },
    {
      'title': 'Steady focus',
      'duration': '8 min',
      'durationSeconds': 480,
      'category': 'Focus',
      'subtitle': 'Sharpen your mind and stay present',
      'iconType': 'concentric_target',
    },
  ];

  void _openAudioPlayer(Map<String, dynamic> session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioPlayerScreen(
          title: session['title'] as String,
          subtitle: session['subtitle'] as String,
          totalDurationSeconds: session['durationSeconds'] as int,
          iconType: session['iconType'] as String,
        ),
      ),
    );
  }

  void _showSupportModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B2017),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFC0FB50),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_rounded, color: Colors.black),
                ),
                const SizedBox(width: 14),
                const Text(
                  'Support & Wellness Resources',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'If you need immediate care or someone to talk to, support is always available.',
              style: TextStyle(color: Color(0xFF9EA798), fontSize: 14),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.phone_in_talk_rounded, color: Color(0xFFC0FB50)),
              title: const Text('24/7 Support Helpline', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Free and confidential support', style: TextStyle(color: Color(0xFF9EA798))),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFFC0FB50)),
              title: const Text('Chat with a Mentor', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Text-based guidance', style: TextStyle(color: Color(0xFF9EA798))),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildTileIcon(String iconType) {
    switch (iconType) {
      case 'dashed_circle':
        return SizedBox(
          width: 32,
          height: 32,
          child: CustomPaint(
            painter: DashedCirclePainter(color: Colors.black.withValues(alpha: 0.85)),
          ),
        );
      case 'crescent_moon':
        return const Icon(
          Icons.brightness_3_outlined,
          color: Colors.black,
          size: 30,
        );
      case 'concentric_target':
        return SizedBox(
          width: 32,
          height: 32,
          child: CustomPaint(
            painter: ConcentricTargetPainter(color: Colors.black.withValues(alpha: 0.85)),
          ),
        );
      default:
        return const Icon(Icons.star_rounded, color: Colors.black, size: 28);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryLime = Color(0xFFC0FB50);
    const darkBackground = Color(0xFF0D100C);
    const cardBackground = Color(0xFF1B2017);
    const textMuted = Color(0xFF9EA798);

    final filteredSessions = _selectedCategory == 'All'
        ? _meditationSessions
        : _meditationSessions
            .where((session) => session['category'] == _selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Top-Right Ambient Green Glow
          Positioned(
            top: -70,
            right: -70,
            child: Container(
              width: 360,
              height: 360,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x40C0FB50),
                    Color(0x2638571A),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 120.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header Tag
                  const Text(
                    'WELLNESS LIBRARY',
                    style: TextStyle(
                      color: primaryLime,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 2. Main Title & Subtitle
                  const Text(
                    'Choose what you\nneed today.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.12,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Short, approachable practices for real-life moments.',
                    style: TextStyle(
                      color: textMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 3. Category Filter Chips Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22.0,
                                vertical: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primaryLime
                                    : const Color(0xFF22281E),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 4. Hero Feature Cards (2 Large Cards)
                  Row(
                    children: [
                      // Card 1: Guided breathing (Dark card)
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.onNavigateToReset,
                          child: Container(
                            height: 165,
                            padding: const EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
                              color: cardBackground,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CustomPaint(
                                    painter: const UpwardArrowsPainter(
                                      color: primaryLime,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Guided\nbreathing',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Card 2: Find support (Neon Lime card)
                      Expanded(
                        child: GestureDetector(
                          onTap: _showSupportModal,
                          child: Container(
                            height: 165,
                            padding: const EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
                              color: primaryLime,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color: Colors.black,
                                  size: 36,
                                ),
                                Text(
                                  'Find\nsupport',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // 5. Meditation Sessions Section Header
                  const Text(
                    'Meditation sessions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Meditation Items List
                  Column(
                    children: filteredSessions.map((session) {
                      final title = session['title'] as String;
                      final duration = session['duration'] as String;
                      final category = session['category'] as String;
                      final iconType = session['iconType'] as String;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: GestureDetector(
                          onTap: () => _openAudioPlayer(session),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: cardBackground,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              children: [
                                // Green Gradient Tile with Custom Icon
                                Container(
                                  width: 76,
                                  height: 76,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFC0FB50),
                                        Color(0xFF7CA630),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: _buildTileIcon(iconType),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Title & Meta Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$duration • $category',
                                        style: const TextStyle(
                                          color: textMuted,
                                          fontSize: 13.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Play Circle Button
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: primaryLime,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 8),

                  // "Trusted Contact" Emergency Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _showSupportModal,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E2B2E),
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.phone_in_talk_rounded,
                              color: Color(0xFFF7B1B6),
                              size: 17,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Trusted contact',
                              style: TextStyle(
                                color: Color(0xFFF7B1B6),
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
