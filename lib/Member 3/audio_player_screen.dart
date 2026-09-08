import 'dart:async';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final int totalDurationSeconds;
  final String iconType;

  const AudioPlayerScreen({
    super.key,
    this.title = 'Deep sleep release',
    this.subtitle = 'Slow down and prepare the body for rest',
    this.totalDurationSeconds = 720, // 12 minutes default
    this.iconType = 'crescent_moon',
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late int _totalSeconds;
  int _currentSeconds = 321; // Starts around 5:21 matching mockup
  bool _isPlaying = true;
  bool _isFavorite = false;
  Timer? _playbackTimer;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.totalDurationSeconds;
    _startTimer();
  }

  void _startTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPlaying && mounted) {
        setState(() {
          if (_currentSeconds < _totalSeconds) {
            _currentSeconds++;
          } else {
            _isPlaying = false;
            timer.cancel();
          }
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startTimer();
      } else {
        _playbackTimer?.cancel();
      }
    });
  }

  void _seek(int secondsChange) {
    setState(() {
      _currentSeconds = (_currentSeconds + secondsChange)
          .clamp(0, _totalSeconds);
    });
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const primaryLime = Color(0xFFC0FB50);
    const darkBackground = Color(0xFF0D100C);
    const textMuted = Color(0xFF9EA798);

    final remainingSeconds = (_totalSeconds - _currentSeconds).clamp(0, _totalSeconds);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Top-Right Ambient Green Glow
          Positioned(
            top: -60,
            right: -60,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  // Top Navigation Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dismiss Down Arrow Button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFF232A20),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),

                      // NOW PLAYING Tag
                      const Text(
                        'NOW PLAYING',
                        style: TextStyle(
                          color: primaryLime,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                        ),
                      ),

                      // Heart Favorite Toggle Button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFF232A20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: _isFavorite ? primaryLime : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 1),

                  // Large Artwork Tile with Crescent Moon
                  Center(
                    child: Container(
                      width: 270,
                      height: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(44),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFD6FE6D),
                            Color(0xFF6E9A2E),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryLime.withValues(alpha: 0.25),
                            blurRadius: 36,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 170,
                          height: 170,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.brightness_3_outlined,
                              color: Color(0xFFC0FB50),
                              size: 68,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Metadata Titles
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textMuted,
                      fontSize: 14,
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Progress Slider & Timers
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 4,
                          activeTrackColor: primaryLime,
                          inactiveTrackColor: const Color(0xFF2C3627),
                          thumbColor: primaryLime,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 7,
                          ),
                          overlayColor: primaryLime.withValues(alpha: 0.2),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 16,
                          ),
                        ),
                        child: Slider(
                          value: _currentSeconds.toDouble(),
                          min: 0,
                          max: _totalSeconds.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              _currentSeconds = value.toInt();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatTime(_currentSeconds),
                              style: const TextStyle(
                                color: textMuted,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '-${_formatTime(remainingSeconds)}',
                              style: const TextStyle(
                                color: textMuted,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 1),

                  // Playback Controls Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Seek -10s
                      IconButton(
                        onPressed: () => _seek(-10),
                        icon: const Icon(
                          Icons.replay_10_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),

                      // Large Play/Pause Primary Button
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: const BoxDecoration(
                            color: primaryLime,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.black,
                            size: 42,
                          ),
                        ),
                      ),

                      // Seek +10s
                      IconButton(
                        onPressed: () => _seek(10),
                        icon: const Icon(
                          Icons.forward_10_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 1),

                  // Footer Subtext
                  const Text(
                    'Demo timer • licensed audio planned',
                    style: TextStyle(
                      color: Color(0xFF677262),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
