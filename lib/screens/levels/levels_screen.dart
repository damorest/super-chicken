import 'package:flutter/material.dart';
import 'package:media_test/core/app_router.dart';
import 'package:media_test/widgets/app_back_button.dart';
import 'package:media_test/widgets/wallet_display.dart';
import 'package:provider/provider.dart';
import '../../services/settings_service.dart';
import '../../widgets/components/app_button.dart';

class LevelsPage extends StatelessWidget {
  const LevelsPage({super.key});

  void _onLevelSelected(BuildContext context, int level) {
    final settings = context.read<SettingsService>();
    settings.setLevel(level);
    Navigator.pushNamed(context, AppRouter.game);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final balance = settings.balance;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBackButton(
                        size: 70,
                        onTap: () => Navigator.pop(context),
                      ),
                      WalletDisplay(balance: balance),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'CHANGE LEVEL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final level = index + 1;
                        final isUnlocked = level <= settings.maxUnlockedLevel;
                        return AppButton(
                          type: AppButtonType.secondary,
                          text: level.toString(),
                          width: 100,
                          height: 100,
                          fontSize: 30,
                          isUnlocked: isUnlocked,
                          onPressed: isUnlocked
                              ? () => _onLevelSelected(context, level)
                              : null,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
