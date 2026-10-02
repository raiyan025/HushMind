import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hushmind/private_check_in_screen.dart';
import 'package:hushmind/support.dart';

class _CheckIn {
  const _CheckIn({
    required this.score,
    required this.factors,
    required this.date,
  });

  final int score; // 1..5
  final List<String> factors;
  final DateTime date;
}

class _Tip {
  const _Tip(this.icon, this.title, this.subtitle);
  final IconData icon;
  final String title;
  final String subtitle;
}

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  static const Color lime = Color(0xFFC9FF73);
  static const Color textLight = Color(0xFFF5F7F1);
  static const Color textMuted = Color(0xFF9AA597);
  static const Color chartCard = Color(0xFF353B33);
  static const Color obsCard = Color(0xFF2D322B);
  static const Color barColor = Color(0xFF738C5F);

  static const List<String> _weekdayLetters = [
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
    'S',
  ];

  static const Map<String, _Tip> _factorTips = {
    'Sleep': _Tip(
      Icons.bedtime_outlined,
      'Sleep shows up often',
      'A calmer wind-down may help.',
    ),
    'Work': _Tip(
      Icons.work_outline,
      'Work shows up often',
      'Small breaks may ease the pressure.',
    ),
    'Study': _Tip(
      Icons.menu_book_outlined,
      'Study shows up often',
      'Short, kind breaks can help.',
    ),
    'Family': _Tip(
      Icons.home_outlined,
      'Family shows up often',
      'It may help to name what you need.',
    ),
    'Health': _Tip(
      Icons.favorite_border,
      'Health shows up often',
      'Gentle routines can be a good start.',
    ),
    'Relationships': _Tip(
      Icons.people_outline,
      'Relationships show up often',
      'Notice who leaves you feeling steady.',
    ),
  };

  Stream<QuerySnapshot<Map<String, dynamic>>>? _stream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _stream = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('moods')
          .orderBy('createdAt', descending: true)
          .limit(30)
          .snapshots();
    }
  }

  List<_CheckIn> _parse(QuerySnapshot<Map<String, dynamic>> snap) {
    return snap.docs.map((doc) {
      final data = doc.data();
      final score = ((data['score'] as num?)?.toInt() ?? 3).clamp(1, 5).toInt();
      final factors =
          (data['factors'] as List?)?.whereType<String>().toList() ??
          <String>[];
      // createdAt is briefly null on a brand-new entry until the server confirms.
      final date =
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
      return _CheckIn(score: score, factors: factors, date: date);
    }).toList();
  }

  void _open(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 110),
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    'YOUR PATTERNS',
                    style: TextStyle(
                      color: lime,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    'Notice gently,\nnot critically.',
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
                    'Insights help reflection; they are not a diagnosis.',
                    style: TextStyle(color: textMuted, fontSize: 14.5),
                  ),
                ),
                const SizedBox(height: 28),
                _buildContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final stream = _stream;
    if (stream == null) {
      return _messageCard('Please sign in to see your patterns.');
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _messageCard(
            "Couldn't load your check-ins.\n"
            'Check your internet connection and Firestore rules.',
          );
        }
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Center(child: CircularProgressIndicator(color: lime)),
          );
        }

        final all = _parse(snapshot.data!);
        if (all.isEmpty) {
          return _messageCard(
            'No check-ins yet.\nYour patterns will appear here after your first one.',
            action: ElevatedButton(
              onPressed: () => _open(const MoodCheckInPage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: lime,
                foregroundColor: const Color(0xFF11170E),
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Start a check-in',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          );
        }

        final recent = all.take(7).toList().reversed.toList();
        final average =
            recent.map((c) => c.score).reduce((a, b) => a + b) / recent.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChart(recent, average),
            const SizedBox(height: 32),
            const Text(
              'Small observations',
              style: TextStyle(
                color: textLight,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._buildObservations(all),
          ],
        );
      },
    );
  }

  Widget _buildChart(List<_CheckIn> recent, double average) {
    const slots = 7;
    const maxBarHeight = 130.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: BoxDecoration(
        color: chartCard,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'LAST 7 CHECK-INS',
                style: TextStyle(
                  color: lime,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${average.toStringAsFixed(1)} / 5',
                style: const TextStyle(
                  color: textLight,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 172,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(slots, (i) {
                final entry = i < recent.length ? recent[i] : null;
                final isLatest = entry != null && i == recent.length - 1;
                final height = entry == null
                    ? 8.0
                    : maxBarHeight * entry.score / 5;

                return SizedBox(
                  width: 28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        height: height,
                        decoration: BoxDecoration(
                          color: entry == null
                              ? const Color(0xFF454C42)
                              : (isLatest ? lime : barColor),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        entry == null
                            ? ''
                            : _weekdayLetters[entry.date.weekday - 1],
                        style: const TextStyle(
                          color: textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildObservations(List<_CheckIn> all) {
    final cards = <Widget>[];

    if (all.length < 3) {
      cards.add(
        _observationCard(
          icon: Icons.auto_awesome,
          title: 'Patterns need a little time',
          subtitle:
              'After a few more check-ins, gentle observations appear here.',
        ),
      );
      return cards;
    }

    if (all.take(3).every((c) => c.score <= 2)) {
      cards.add(
        _observationCard(
          icon: Icons.favorite_border,
          title: "It's been a heavy stretch",
          subtitle:
              "You don't have to carry it alone. Tap to see support options.",
          onTap: () => _open(const SupportPage()),
        ),
      );
      cards.add(const SizedBox(height: 14));
    }

    final counts = <String, int>{};
    for (final c in all) {
      for (final f in c.factors.toSet()) {
        counts[f] = (counts[f] ?? 0) + 1;
      }
    }
    if (counts.isNotEmpty) {
      final top = counts.entries.reduce((a, b) => b.value > a.value ? b : a);
      final tip = _factorTips[top.key];
      if (top.value >= 2 && tip != null) {
        cards.add(
          _observationCard(
            icon: tip.icon,
            title: tip.title,
            subtitle: tip.subtitle,
          ),
        );
        cards.add(const SizedBox(height: 14));
      }
    }

    cards.add(
      _observationCard(
        icon: Icons.auto_awesome,
        title: 'You keep returning',
        subtitle: 'Consistency makes patterns easier to notice.',
      ),
    );

    return cards;
  }

  Widget _observationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Material(
      color: obsCard,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: lime, size: 26),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: textLight,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: textMuted,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageCard(String text, {Widget? action}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: obsCard,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: textMuted, fontSize: 14, height: 1.5),
          ),
          if (action != null) ...[const SizedBox(height: 18), action],
        ],
      ),
    );
  }
}
