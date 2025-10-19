import 'package:flutter/material.dart';
import 'package:media_test/core/app_router.dart';
import '../../widgets/components/app_button.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'Play',
      'Profile',
      'Settings',
      'Leaderboard',
      'Shop',
      'How to Play',
      'Exit',
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Image.asset(
                    'assets/images/Rectangle.png',
                    width: 50,
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/Circle.png',
                    width: 50,
                    height: 50,
                  ),
                ]),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  color: Colors.pinkAccent,
                  child: Column(
                    children: [
                      const Text(
                        'MENU',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 32),
                              for (final label in buttons) ...[
                                AppButton(
                                  text: label,
                                  backgroundImage: 'assets/images/menu_but.png',
                                  onPressed: () {
                                    debugPrint('Pressed $label');
                                    Navigator.pushNamed(context, AppRouter.home);
                                  },
                                ),
                                const SizedBox(height: 12),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
