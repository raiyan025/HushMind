import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  static const Color lime = Color(0xFFC9FF73);
  static const Color textLight = Color(0xFFF5F7F1);
  static const Color textMuted = Color(0xFF9AA597);
  static const Color darkText = Color(0xFF11170E);
  static const Color card = Color(0xFF2B302A);
  static const Color dangerCard = Color(0xFF473030);
  static const Color dangerAccent = Color(0xFFFF8C8C);

  static const String emergencyNumber = '999';
  static const String nimhUrl = 'https://nimh.gov.bd/';

  Future<void> _callEmergency(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final ok = await launchUrl(Uri(scheme: 'tel', path: emergencyNumber));
      if (!ok) throw Exception('Could not open dialer');
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Couldn't open the dialer. Please dial 999 directly."),
        ),
      );
    }
  }

  Future<void> _openNimh(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final ok = await launchUrl(
        Uri.parse(nimhUrl),
        mode: LaunchMode.externalApplication,
      );
      if (!ok) throw Exception('Could not open link');
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text("Couldn't open the website.")),
      );
    }
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
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
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
                        'SUPPORT & SAFETY',
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
                      'You deserve\nreal support.',
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
                      'Wellness tools are not emergency care.',
                      style: TextStyle(color: textMuted, fontSize: 14.5),
                    ),
                  ),
                  const SizedBox(height: 28),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: dangerCard,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.add, color: dangerAccent, size: 18),
                            SizedBox(width: 6),
                            Text(
                              'IMMEDIATE DANGER',
                              style: TextStyle(
                                color: dangerAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'If you feel at immediate risk, call 999 now or use '
                          'your local emergency services.',
                          style: TextStyle(
                            color: textLight,
                            fontSize: 15,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () => _callEmergency(context),
                            icon: const Icon(Icons.call_rounded, size: 20),
                            label: const Text(
                              'Call 999',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lime,
                              foregroundColor: darkText,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            'National Emergency Helpline · Bangladesh',
                            style: TextStyle(color: textMuted, fontSize: 12.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Text(
                    'Professional care',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Material(
                    color: card,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => _openNimh(context),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: Color(0xFF1F251E),
                              child: Icon(Icons.add, color: textLight),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'National Institute of Mental Health',
                                    style: TextStyle(
                                      color: textLight,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Official information and services\nin Bangladesh',
                                    style: TextStyle(
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
                  ),
                  const SizedBox(height: 32),

                  const Text(
                    'Ground yourself now',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: card,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '5–4–3–2–1 practice',
                          style: TextStyle(
                            color: textLight,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          '5 things you see • 4 things you feel\n'
                          '3 hear • 2 smell • 1 taste',
                          style: TextStyle(
                            color: textMuted,
                            fontSize: 14.5,
                            height: 1.5,
                          ),
                        ),
                      ],
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
}
