import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class _Mood {
  const _Mood(this.label, this.icon, this.score);
  final String label;
  final IconData icon;
  final int score;
}

class MoodCheckInPage extends StatefulWidget {
  const MoodCheckInPage({super.key});

  @override
  State<MoodCheckInPage> createState() => _MoodCheckInPageState();
}

class _MoodCheckInPageState extends State<MoodCheckInPage> {
  static const Color lime = Color(0xFFC9FF73);
  static const Color textLight = Color(0xFFF5F7F1);
  static const Color textMuted = Color(0xFF9AA597);
  static const Color darkText = Color(0xFF11170E);
  static const Color panel = Color(0xFF2B302A);
  static const Color chipBg = Color(0xFF222822);
  static const Color noteBg = Color(0xFF212621);

  static const List<_Mood> _moods = [
    _Mood('Heavy', Icons.cloud_outlined, 1),
    _Mood('Low', Icons.water_drop_outlined, 2),
    _Mood('Okay', Icons.circle_outlined, 3),
    _Mood('Good', Icons.wb_twilight_outlined, 4),
    _Mood('Bright', Icons.auto_awesome, 5),
  ];

  static const List<String> _factors = [
    'Work',
    'Study',
    'Family',
    'Sleep',
    'Health',
    'Relationships',
  ];

  int _selectedMood = 2;
  final Set<String> _selectedFactors = {};
  final TextEditingController _noteController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showMessage('Please sign in again.');
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isSaving = true);

    final mood = _moods[_selectedMood];
    final write = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('moods')
        .add({
          'score': mood.score,
          'mood': mood.label.toLowerCase(),
          'factors': _factors.where(_selectedFactors.contains).toList(),
          'note': _noteController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

    try {
      await write.timeout(const Duration(seconds: 8));
      if (mounted) navigator.pop();
      messenger.showSnackBar(const SnackBar(content: Text('Check-in saved.')));
    } on TimeoutException {
      if (mounted) navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            "You seem to be offline. Your check-in will sync when you're back online.",
          ),
        ),
      );
    } on FirebaseException catch (e) {
      _showMessage(
        e.code == 'permission-denied'
            ? 'Permission denied. Check your Firestore rules.'
            : 'Could not save. ${e.message ?? e.code}',
      );
    } catch (_) {
      _showMessage('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF1F251E),
                          foregroundColor: textLight,
                          minimumSize: const Size(40, 40),
                        ),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'PRIVATE CHECK-IN',
                        style: TextStyle(
                          color: lime,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      'What feels true\nright now?',
                      style: TextStyle(
                        color: textLight,
                        fontSize: 32,
                        height: 1.1,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      'Choose the closest feeling—not the perfect label.',
                      style: TextStyle(color: textMuted, fontSize: 14.5),
                    ),
                  ),
                  const SizedBox(height: 28),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: panel,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        for (int i = 0; i < _moods.length; i++)
                          Expanded(child: _buildMoodItem(i)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'What may be influencing this?',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [for (final f in _factors) _buildChip(f)],
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Add a private note',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 116,
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
                    decoration: BoxDecoration(
                      color: noteBg,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _noteController,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: textLight, fontSize: 15),
                      decoration: const InputDecoration(
                        hintText: 'A few words about this moment…',
                        hintStyle: TextStyle(color: textMuted, fontSize: 15),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lime,
                        foregroundColor: darkText,
                        disabledBackgroundColor: const Color(0xFF8FB257),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: darkText,
                              ),
                            )
                          : const Text(
                              'Save check-in',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodItem(int index) {
    final mood = _moods[index];
    final selected = index == _selectedMood;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _selectedMood = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: selected ? lime : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(mood.icon, size: 26, color: selected ? darkText : textLight),
            const SizedBox(height: 14),
            Text(
              mood.label,
              maxLines: 1,
              style: TextStyle(
                color: selected ? darkText : textMuted,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    final selected = _selectedFactors.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (selected) {
            _selectedFactors.remove(label);
          } else {
            _selectedFactors.add(label);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? lime : chipBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? darkText : textLight,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
