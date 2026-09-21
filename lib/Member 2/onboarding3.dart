import 'package:flutter/material.dart';
import 'package:hushmind/Member 1/login.dart';

class OnboardingPrivacy extends StatelessWidget {
  const OnboardingPrivacy({super.key});

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
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Color(0xFF99C85E), fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 270),
              Row(
                children: [
                  const SizedBox(width: 32),
                  Icon(Icons.lock_outline, color: Color(0xFFC9FF73), size: 50),
                ],
              ),
              const SizedBox(height: 35),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Your words stay yours',
                    style: TextStyle(
                      color: Color(0xFF99C85E),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'A private space\nto reflect.',
                    style: TextStyle(
                      color: Color(0xFFF5F7F1),
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Keep a personal journal and review\n'
                    'emotional patterns. HushMind supports\n'
                    'wellness; it does not diagnose.',
                    style: TextStyle(color: Color(0xFFB1B8AA), fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC9FF73),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(350, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),

                    child: const Text('Enter HushMind'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//                         const Text(
//                           "Your words stay yours",
//                           style: TextStyle(
//                             color: accent,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.2,
//                           ),
//                         ),
//
//                         const SizedBox(height: 12),
//
//                         const Text(
//                           "A private space\nto reflect.",
//                           style: TextStyle(
//                             color: white,
//                             fontSize: 38,
//                             fontWeight: FontWeight.w500,
//                             height: 1.15,
//                             letterSpacing: -0.4,
//                           ),
//                         ),
//
//                         const SizedBox(height: 16),
//
//                         const SizedBox(
//                           width: 320,
//
//                           child: Text(
//                             "Keep a personal journal and review emotional patterns. HushMind supports wellness; it does not diagnose.",
//                             style: TextStyle(
//                               color: muted,
//                               fontSize: 15.5,
//                               height: 1.5,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 //dots(2),
//
//                 const SizedBox(height: 20),
//
//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SignInScreen(),
//                         ),
//                       );
//                     },
//
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: accent,
//                       elevation: 0,
//
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                     ),
//
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//
//                       children: [
//                         Icon(Icons.north_east, color: background, size: 18),
//
//                         SizedBox(width: 8),
//
//                         Text(
//                           "Enter HushMind",
//                           style: TextStyle(
//                             color: background,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
