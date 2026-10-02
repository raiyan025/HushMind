import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MeditationPlayerScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String audioPath;
  final IconData icon;

  const MeditationPlayerScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.audioPath,
    required this.icon,
  });

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  final AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();

    player.onPositionChanged.listen((value) {
      setState(() {
        position = value;
      });
    });

    player.onDurationChanged.listen((value) {
      setState(() {
        duration = value;
      });
    });

    player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void togglePlay() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(AssetSource(widget.audioPath));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void seek(int seconds) async {
    Duration newPosition = position + Duration(seconds: seconds);

    if (newPosition < Duration.zero) {
      newPosition = Duration.zero;
    }

    if (newPosition > duration) {
      newPosition = duration;
    }

    await player.seek(newPosition);
  }

  String formatTime(Duration time) {
    String minutes = time.inMinutes.toString();
    String seconds = (time.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    Duration remaining = duration - position;

    return Scaffold(
      body: Container(
        color: const Color(0xFF0C130B),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: circleButton(
                          Icons.keyboard_arrow_down,
                          () => Navigator.pop(context),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'NOW PLAYING',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC7F464),
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Icon(widget.icon, size: 72, color: Colors.black54),
                ),

                const SizedBox(height: 35),

                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),

                const SizedBox(height: 30),

                Slider(
                  value: position.inSeconds.toDouble().clamp(
                    0,
                    duration.inSeconds.toDouble(),
                  ),
                  max: duration.inSeconds > 0
                      ? duration.inSeconds.toDouble()
                      : 1,
                  activeColor: const Color(0xFFC7F464),
                  inactiveColor: Colors.white12,
                  onChanged: (value) {
                    player.seek(Duration(seconds: value.toInt()));
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(position),
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '-${formatTime(remaining)}',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.replay_10, color: Colors.white70),
                      onPressed: () => seek(-10),
                    ),

                    const SizedBox(width: 30),

                    InkWell(
                      onTap: togglePlay,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC7F464),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 38,
                        ),
                      ),
                    ),

                    const SizedBox(width: 30),

                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.forward_10, color: Colors.white70),
                      onPressed: () => seek(10),
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFC7F464),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 20),
      ),
    );
  }
}
