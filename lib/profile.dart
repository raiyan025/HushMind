import 'package:flutter/material.dart';
import 'package:hushmind/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              const SizedBox(height: 55),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Your space',
                    style: TextStyle(color: Color(0xFFC9FF73), fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Make HushMind\nfeel like yours.',
                    style: TextStyle(color: Color(0xFFF5F7F1), fontSize: 20),
                  ),
                ],
              ),

              const SizedBox(height: 100),

              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(color: Color(0xFFC9FF73)),
                child: const Icon(Icons.person, color: Colors.black, size: 40),
              ),

              const SizedBox(height: 20),

              const Text(
                'Name',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              const SizedBox(height: 5),

              const Text(
                'name@gmail.com',
                style: TextStyle(color: Color(0xFFB1B8AA), fontSize: 14),
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC9FF73),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(350, 50),
                ),
                child: const Text('Sign out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
