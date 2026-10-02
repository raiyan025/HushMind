import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hushmind/journal_editor.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  static const Color lime = Color(0xFFC9FF73);
  static const Color cardColor = Color(0xFF242820);
  static const Color textLight = Color(0xFFF5F7F1);
  static const Color textMuted = Color(0xFFB1B8AA);
  static const Color accent = Color(0xFF99C85E);

  Stream<QuerySnapshot<Map<String, dynamic>>>? _entriesStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _entriesStream = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('journals')
          .orderBy('createdAt', descending: true)
          .snapshots();
    }
  }

  void _openEditor({String? entryId, String? initialText}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            JournalEditor(entryId: entryId, initialText: initialText),
      ),
    );
  }

  Future<void> _confirmDelete(
    DocumentReference<Map<String, dynamic>> ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: cardColor,
        title: const Text(
          'Delete this reflection?',
          style: TextStyle(color: textLight),
        ),
        content: const Text(
          "This can't be undone.",
          style: TextStyle(color: textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel', style: TextStyle(color: textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFFF8A80)),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.delete();
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete. ${e.message ?? e.code}')),
      );
    }
  }

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'Just now';
    final d = timestamp.toDate();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour12 = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? 'PM' : 'AM';
    return '${months[d.month - 1]} ${d.day}, ${d.year} · $hour12:$minute $period';
  }

  Widget _message(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: textMuted, fontSize: 14, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildEntries() {
    final stream = _entriesStream;
    if (stream == null) {
      return _message('Please sign in to see your reflections.');
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _message(
            "Couldn't load your reflections.\n"
            'Check your internet connection and Firestore rules.\n\n'
            '${snapshot.error}',
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: lime));
        }

        final docs = snapshot.data!.docs;
        if (docs.isEmpty) {
          return _message(
            'No reflections yet.\nTap + to write your first one.',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: docs.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => _buildEntryCard(docs[index]),
        );
      },
    );
  }

  Widget _buildEntryCard(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final text = (data['text'] as String?) ?? '';
    final createdAt = data['createdAt'] as Timestamp?;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openEditor(entryId: doc.id, initialText: text),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 4, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDate(createdAt).toUpperCase(),
                      style: const TextStyle(
                        color: accent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () => _confirmDelete(doc.reference),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: textMuted,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  text,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textLight,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          Column(
            children: [
              const SizedBox(height: 60),

              Padding(
                padding: const EdgeInsets.only(left: 32, right: 20),
                child: Row(
                  children: [
                    const Text(
                      'Private Journal',
                      style: TextStyle(
                        color: lime,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => _openEditor(),
                      style: IconButton.styleFrom(
                        backgroundColor: lime,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(50, 50),
                      ),
                      icon: const Icon(Icons.add, size: 25),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Row(
                children: [
                  SizedBox(width: 32),
                  Text(
                    'Put the feeling\nsomewhere safe.',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Row(
                children: [
                  SizedBox(width: 32),
                  Text(
                    'Write freely. You never have to share it.',
                    style: TextStyle(color: textMuted, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => _openEditor(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cardColor,
                    foregroundColor: textLight,
                    minimumSize: const Size(double.infinity, 120),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TODAY'S PROMPT",
                        style: TextStyle(
                          color: accent,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'What would feel\nsupportive today?',
                        style: TextStyle(color: textLight, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'Recent Reflections',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Expanded(child: _buildEntries()),
            ],
          ),
        ],
      ),
    );
  }
}
