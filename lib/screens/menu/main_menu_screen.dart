import 'package:flutter/material.dart';
import 'package:media_test/core/app_router.dart';
import '../../widgets/base_screen.dart';
import '../../widgets/components/app_button.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'label': 'Play', 'route': AppRouter.game},
      {'label': 'Profile', 'route': AppRouter.profile},
      {'label': 'Settings', 'route': AppRouter.settings},
      {'label': 'Leaderboard', 'route': AppRouter.leaderboard},
      {'label': 'Shop', 'route': AppRouter.shop},
      {'label': 'How\nto Play', 'route': AppRouter.howToPlay},
      {'label': 'Exit', 'route': null},
    ];

    return BaseScreen(
      title: 'MENU',
      width: 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in menuItems) ...[
            AppButton(
              fontSize: 20,
              width: 180,
              height: 90,
              text: item['label'] as String,
              onPressed: item['route'] != null
                  ? () => Navigator.pushNamed(context, item['route'] as String)
                  : () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
