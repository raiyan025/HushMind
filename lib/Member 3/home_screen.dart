import 'package:flutter/material.dart';
import 'private_check_in_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onNavigateToCheckIn;
  final VoidCallback? onNavigateToReset;

  const HomeScreen({
    super.key,
    this.onNavigateToCheckIn,
    this.onNavigateToReset,
  });

  void _openDeepSleepAudio(BuildContext context) {
    _showFeatureToast(context, 'Deep sleep release');
  }

  void _showFeatureToast(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFC0FB50),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Row(
          children: [
            const Icon(Icons.star_rounded, color: Colors.black),
            const SizedBox(width: 12),
            Text(
              '$title feature tapped',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryLime = Color(0xFFC0FB50);
    const darkBackground = Color(0xFF0D100C);
    const cardBackground = Color(0xFF1B2017);
    const textMuted = Color(0xFF9EA798);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Top-Right Ambient Green Glow
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 340,
              height: 340,
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
                  // 1. Top Greeting Bar
                  Row(
                    children: [
                      // Avatar Star Badge
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: primaryLime,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // User Greeting Column
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good evening, Alex',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Make a little room for yourself.',
                              style: TextStyle(
                                color: textMuted,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Favorite / Heart Action Button
                      GestureDetector(
                        onTap: () => _showFeatureToast(context, 'Favorites'),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFF232A20),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 2. TODAY'S CHECK-IN Hero Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22.0),
                    decoration: BoxDecoration(
                      color: cardBackground,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "TODAY'S CHECK-IN",
                              style: TextStyle(
                                color: primaryLime,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: primaryLime,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          'How is your inner\nweather right now?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            height: 1.18,
                            letterSpacing: -0.4,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'There is no right answer—just notice what is here.',
                          style: TextStyle(
                            color: textMuted,
                            fontSize: 13.5,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 22),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: onNavigateToCheckIn ??
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivateCheckInScreen(),
                                    ),
                                  );
                                },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryLime,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              'Check in now',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 3. Quick Reset Section
                  const Text(
                    'Quick reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      // Breathe (2 min) Card -> Navigates to TwoMinuteResetScreen
                      Expanded(
                        child: _buildQuickResetCard(
                          context: context,
                          icon: Icons.air_rounded,
                          title: 'Breathe',
                          subtitle: '2 min',
                          onTap: onNavigateToReset ??
                              () => _showFeatureToast(context, 'Breathe'),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Meditate (5 min) Card
                      Expanded(
                        child: _buildQuickResetCard(
                          context: context,
                          icon: Icons.blur_on_rounded,
                          title: 'Meditate',
                          subtitle: '5 min',
                          onTap: () => _showFeatureToast(context, 'Meditate'),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Reflect (Journal) Card
                      Expanded(
                        child: _buildQuickResetCard(
                          context: context,
                          icon: Icons.edit_note_rounded,
                          title: 'Reflect',
                          subtitle: 'Journal',
                          onTap: () => _showFeatureToast(context, 'Reflect'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // 4. For your evening Section
                  const Text(
                    'For your evening',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Audio Card with Crescent Moon
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _openDeepSleepAudio(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              // Crescent Moon Tile
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFD6FE6D),
                                      Color(0xFF81B028),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.nights_stay_rounded,
                                  color: Colors.black,
                                  size: 36,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Details Column
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Deep sleep release',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '12 min • Sleep',
                                      style: TextStyle(
                                        color: textMuted,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Play Button
                              GestureDetector(
                                onTap: () => _openDeepSleepAudio(context),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: const BoxDecoration(
                                    color: primaryLime,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.black,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Floating "Trusted Contact" Emergency Button
                      Positioned(
                        right: 12,
                        bottom: -4,
                        child: GestureDetector(
                          onTap: () => _showFeatureToast(context, 'Trusted Contact'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A2B2D),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 10,
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
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Trusted contact',
                                  style: TextStyle(
                                    color: Color(0xFFF7B1B6),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickResetCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    const primaryLime = Color(0xFFC0FB50);
    const cardBackground = Color(0xFF1B2017);
    const textMuted = Color(0xFF9EA798);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryLime,
              size: 26,
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: textMuted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
