import 'dart:async';
import 'package:flutter/material.dart';

class MeditationPlayerScreen extends StatefulWidget {
  const MeditationPlayerScreen({super.key});

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  final Duration _totalDuration = const Duration(minutes: 5);
  Duration _currentPosition = const Duration(minutes: 2, seconds: 48);

  bool _isPlaying = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() => _isPlaying = !_isPlaying);

    if (_isPlaying) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_currentPosition < _totalDuration) {
          setState(() {
            _currentPosition += const Duration(seconds: 1);
          });
        } else {
          timer.cancel();
          setState(() => _isPlaying = false);
        }
      });
    } else {
      _timer?.cancel();
    }
  }

  void _seekBy(int seconds) {
    final nextSeconds = (_currentPosition.inSeconds + seconds).clamp(0, _totalDuration.inSeconds);
    setState(() {
      _currentPosition = Duration(seconds: nextSeconds);
    });
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString();
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    const accentGreen = Color(0xFFC6FF75);
    const darkBg = Color(0xFF0C120C);
    final remainingDuration = _totalDuration - _currentPosition;

    return Scaffold(
      backgroundColor: darkBg,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.4),
            radius: 1.0,
            colors: [Color(0xFF263D18), darkBg],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Top Bar
                SizedBox(
                  height: 40,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildCircleIconButton(
                          Icons.keyboard_arrow_down,
                          () => Navigator.maybePop(context),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'NOW PLAYING',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),

                // Artwork Card
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFAFE678), Color(0xFF537A3D)],
                    ),
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.self_improvement,
                      size: 72,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Spacer(flex: 2),

                // Titles
                const Text(
                  'Quiet the noise',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A gentle reset for an active mind',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 32),

                // Progress Bar
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                    activeTrackColor: accentGreen,
                    inactiveTrackColor: Colors.white12,
                    thumbColor: accentGreen,
                  ),
                  child: Slider(
                    value: _currentPosition.inSeconds.toDouble(),
                    max: _totalDuration.inSeconds.toDouble(),
                    onChanged: (val) {
                      setState(() {
                        _currentPosition = Duration(seconds: val.toInt());
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_currentPosition),
                        style: const TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                      Text(
                        '-${_formatDuration(remainingDuration)}',
                        style: const TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.replay_10, color: Colors.white70),
                      onPressed: () => _seekBy(-10),
                    ),
                    const SizedBox(width: 32),
                    GestureDetector(
                      onTap: _togglePlayPause,
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: accentGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 38,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.forward_10, color: Colors.white70),
                      onPressed: () => _seekBy(10),
                    ),
                  ],
                ),
                const Spacer(flex: 1),

                // Demo Notice
                const Text(
                  'Demo timer • add licensed audio before release',
                  style: TextStyle(color: Colors.white30, fontSize: 12),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIconButton(IconData icon, VoidCallback onTap, {Color iconColor = Colors.black}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFC6FF75),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }
}