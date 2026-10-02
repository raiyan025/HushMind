import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JournalEditor extends StatefulWidget {
  const JournalEditor({super.key, this.entryId, this.initialText});

  final String? entryId;
  final String? initialText;

  @override
  State<JournalEditor> createState() => _JournalEditorState();
}

class _JournalEditorState extends State<JournalEditor> {
  static const Color lime = Color(0xFFC9FF73);
  static const Color textLight = Color(0xFFF5F7F1);
  static const Color textMuted = Color(0xFFB1B8AA);

  late final TextEditingController _controller;
  bool _isSaving = false;

  bool get _isEditing => widget.entryId != null;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final text = _controller.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    if (text.isEmpty) {
      _showMessage('Write something before saving.');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showMessage('Please sign in again.');
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isSaving = true);

    final entries = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('journals');

    final Future<void> write = _isEditing
        ? entries.doc(widget.entryId).update({
            'text': text,
            'updatedAt': FieldValue.serverTimestamp(),
          })
        : entries
              .add({
                'text': text,
                'createdAt': FieldValue.serverTimestamp(),
                'updatedAt': FieldValue.serverTimestamp(),
              })
              .then((_) {});

    try {
      await write.timeout(const Duration(seconds: 8));
      if (mounted) navigator.pop();
    } on TimeoutException {
      if (mounted) navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            "You seem to be offline. Your reflection will sync when you're back online.",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(50, 50),
                        ),
                        icon: const Icon(Icons.close, size: 28),
                      ),
                      TextButton(
                        onPressed: _isSaving ? null : _save,
                        child: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: lime,
                                ),
                              )
                            : const Text(
                                '✓  Save',
                                style: TextStyle(
                                  color: lime,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'What would feel supportive today?',
                    style: TextStyle(color: textLight, fontSize: 15),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    _isEditing ? 'Your reflection' : "Today's reflection",
                    style: const TextStyle(color: textLight, fontSize: 30),
                  ),

                  const SizedBox(height: 15),

                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: !_isEditing,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: textLight, fontSize: 18),
                      decoration: const InputDecoration(
                        hintText: 'Write without editing yourself...',
                        hintStyle: TextStyle(color: textMuted),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.lock_outline, color: textMuted, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Private by design',
                        style: TextStyle(color: textMuted, fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
