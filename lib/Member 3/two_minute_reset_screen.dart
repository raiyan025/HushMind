import 'dart:async';
import 'package:flutter/material.dart';

class TwoMinuteResetScreen extends StatefulWidget {
  const TwoMinuteResetScreen({super.key});

  @override
  State<TwoMinuteResetScreen> createState() => _TwoMinuteResetScreenState();
}

class _TwoMinuteResetScreenState extends State<TwoMinuteResetScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  Timer? _phaseTimer;
  Timer? _countdownTimer;

  bool _isPaused = false;
  int _secondsRemaining = 120; // 2 minutes total
  String _currentPhaseText = 'Breathe in';
  int _phaseIndex = 0; // 0: Inhale, 1: Hold (Full), 2: Exhale, 3: Hold (Empty)

  final List<String> _phaseTexts = [
    'Breathe in',
    'Hold',
    'Breathe out',
    'Hold',
  ];

  @override
  void initState() {
    super.initState();

    // Set up 16-second loop controller for 4-4-4-4 breathing pattern
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    );

    // Scale animation pulsing between 0.85 and 1.15
    _scaleAnimation = TweenSequence<double>([
      // 0.0 to 0.25 (4s): Inhale (Expand 0.85 -> 1.15)
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.85, end: 1.15)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      // 0.25 to 0.50 (4s): Hold at full size (1.15)
      TweenSequenceItem(
        tween: ConstantTween<double>(1.15),
        weight: 25,
      ),
      // 0.50 to 0.75 (4s): Exhale (Contract 1.15 -> 0.85)
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 0.85)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      // 0.75 to 1.00 (4s): Hold at empty size (0.85)
      TweenSequenceItem(
        tween: ConstantTween<double>(0.85),
        weight: 25,
      ),
    ]).animate(_animController);

    _startSession();
  }

  void _startSession() {
    _animController.repeat();

    // Phase text updater every 4 seconds
    _phaseTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_isPaused && mounted) {
        setState(() {
          _phaseIndex = (_phaseIndex + 1) % _phaseTexts.length;
          _currentPhaseText = _phaseTexts[_phaseIndex];
        });
      }
    });

    // 2-minute countdown timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && mounted) {
        if (_secondsRemaining > 0) {
          setState(() {
            _secondsRemaining--;
          });
        } else {
          _pauseSession();
          _showCompletionDialog();
        }
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _animController.stop();
      } else {
        _animController.repeat(min: _animController.value);
      }
    });
  }

  void _pauseSession() {
    setState(() {
      _isPaused = true;
      _animController.stop();
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B2017),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Reset Complete!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Great job taking 2 minutes for yourself. You should feel centered and calm.',
          style: TextStyle(color: Color(0xFF9EA798)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _secondsRemaining = 120;
                _isPaused = false;
                _animController.repeat();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBFF646),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Restart Session', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _phaseTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const primaryLime = Color(0xFFBFF646);
    const darkBackground = Color(0xFF0F120D);
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

          // Bottom-Left Ambient Green Glow
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
                // Top Scrollable Content
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
                        // Header bar
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
                              '2-MINUTE RESET',
                              style: TextStyle(
                                color: primaryLime,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const Spacer(),
                            // Remaining Time indicator
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF232A20),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                _formatTime(_secondsRemaining),
                                style: const TextStyle(
                                  color: primaryLime,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Title
                        const Text(
                          'Breathe with\nthe light.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Cadence Subtitle
                        const Text(
                          'Inhale for 4 • hold for 4 • exhale for 4',
                          style: TextStyle(
                            color: textMuted,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        const SizedBox(height: 36),

                        // Center Animated Breathing Orb Container
                        Center(
                          child: AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              final scale = _scaleAnimation.value;
                              return Transform.scale(
                                scale: scale,
                                child: Container(
                                  width: 230,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const RadialGradient(
                                      colors: [
                                        Color(0xFFD6FE6D),
                                        Color(0xFF9ECF3B),
                                      ],
                                      stops: [0.3, 1.0],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryLime.withValues(alpha: 0.4),
                                        blurRadius: 36 * scale,
                                        spreadRadius: 8 * scale,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 300),
                                          child: Text(
                                            _currentPhaseText,
                                            key: ValueKey<String>(_currentPhaseText),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: -0.3,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        const Text(
                                          'Stay with this moment',
                                          style: TextStyle(
                                            color: Color(0xFF2C3522),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Safety Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 18.0,
                          ),
                          decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Stop if you feel dizzy. Return to your normal breathing.',
                            style: TextStyle(
                              color: textMuted,
                              fontSize: 13,
                              height: 1.35,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Pause / Resume Session Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: _togglePause,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryLime,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isPaused ? 'Resume session' : 'Pause session',
                        style: const TextStyle(
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
