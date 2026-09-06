import 'package:flutter/material.dart';

class PrivateCheckInScreen extends StatefulWidget {
  const PrivateCheckInScreen({super.key});

  @override
  State<PrivateCheckInScreen> createState() => _PrivateCheckInScreenState();
}

class _PrivateCheckInScreenState extends State<PrivateCheckInScreen> {
  // Currently selected feeling ('Heavy', 'Low', 'Okay', 'Good', 'Bright')
  String _selectedFeeling = 'Okay';

  // Selected influences set
  final Set<String> _selectedInfluences = {'Family'};

  // Private note text controller
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _feelings = [
    {
      'label': 'Heavy',
      'icon': Icons.pie_chart_outline_rounded,
    },
    {
      'label': 'Low',
      'icon': Icons.sentiment_dissatisfied_rounded,
    },
    {
      'label': 'Okay',
      'icon': Icons.blur_on_rounded,
    },
    {
      'label': 'Good',
      'icon': Icons.sentiment_satisfied_rounded,
    },
    {
      'label': 'Bright',
      'icon': Icons.auto_awesome_rounded,
    },
  ];

  final List<String> _influences = [
    'Work',
    'Study',
    'Family',
    'Sleep',
    'Health',
    'Relationships',
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _toggleInfluence(String influence) {
    setState(() {
      if (_selectedInfluences.contains(influence)) {
        _selectedInfluences.remove(influence);
      } else {
        _selectedInfluences.add(influence);
      }
    });
  }

  void _onSave() {
    FocusScope.of(context).unfocus();
    final noteText = _noteController.text.trim();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFBFF646),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.black),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                noteText.isNotEmpty
                    ? 'Check-in saved! Feeling "$_selectedFeeling" with note.'
                    : 'Check-in saved! Feeling "$_selectedFeeling".',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryLime = Color(0xFFBFF646);
    const darkBackground = Color(0xFF0F120D);
    const cardBackground = Color(0xFF1B2017);
    const unselectedPillBg = Color(0xFF242A20);
    const textMuted = Color(0xFF9EA798);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Ambient Green Glow in top-right
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x40BFF646),
                    Color(0x2638571A),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Ambient Green Glow in bottom-left
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x1FBFF646),
                    Colors.transparent,
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Scrollable content area
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Navigation Header
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Back button tapped'),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );
                              },
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF232A20),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.chevron_left_rounded,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'PRIVATE CHECK-IN',
                              style: TextStyle(
                                color: primaryLime,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Title Question
                        const Text(
                          'What feels true\nright now?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Subtitle Description
                        const Text(
                          'Choose the closest feeling—not the perfect label.',
                          style: TextStyle(
                            color: textMuted,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Mood Selector Card Container
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _feelings.map((feeling) {
                              final label = feeling['label'] as String;
                              final iconData = feeling['icon'] as IconData;
                              final isSelected = _selectedFeeling == label;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedFeeling = label;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                  width: isSelected ? 72 : 56,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? primaryLime
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        iconData,
                                        size: 24,
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        label,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.black
                                              : textMuted,
                                          fontSize: 12,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Influences Section
                        const Text(
                          'What may be influencing this?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Influence Chips Wrap
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 12.0,
                          children: _influences.map((influence) {
                            final isSelected =
                                _selectedInfluences.contains(influence);

                            return GestureDetector(
                              onTap: () => _toggleInfluence(influence),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22.0,
                                  vertical: 12.0,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryLime
                                      : unselectedPillBg,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  influence,
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
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 32),

                        // Private Note Section Header
                        const Text(
                          'Add a private note',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Private Note Text Input Container
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 14.0,
                          ),
                          child: TextField(
                            controller: _noteController,
                            minLines: 3,
                            maxLines: 5,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.4,
                            ),
                            cursorColor: primaryLime,
                            decoration: const InputDecoration(
                              hintText: 'A few words about this moment...',
                              hintStyle: TextStyle(
                                color: Color(0xFF677061),
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Fixed Bottom Primary Action Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: _onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryLime,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Save check-in',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
