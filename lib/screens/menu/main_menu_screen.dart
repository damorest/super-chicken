import 'package:flutter/material.dart';
import 'package:media_test/core/app_router.dart';
import '../../widgets/app_back_button.dart';
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
                    AppBackButton(
                      onTap: () => Navigator.pop(context),
                    ),
                    const Stack(children: [
                      AppButton(
                        type: AppButtonType.circle,
                        width: 50,
                        height: 50,
                      ),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    color: Colors.pinkAccent,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (final label in buttons) ...[
                                  AppButton(
                                    text: label,
                                    onPressed: () {
                                      debugPrint('Pressed $label');
                                      Navigator.pushNamed(
                                          context, AppRouter.home);
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
