import 'package:flutter/material.dart';
import 'package:media_test/widgets/components/app_button.dart';
import 'package:provider/provider.dart';
import '../../services/settings_service.dart';
import '../../widgets/base_screen.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsService>();
    final playerName = settings.username;
    final playerScore = settings.bestScore;

    final List<Map<String, dynamic>> players = [
      {'name': 'Alice', 'score': 120},
      {'name': 'Bob', 'score': 98},
      {'name': 'Charlie', 'score': 8},
      {'name': 'Diana', 'score': 76},
      {'name': 'Eve', 'score': 23},
      {'name': 'Frank', 'score': 54},
      {'name': 'Grace', 'score': 30},
      {'name': 'Hank', 'score': 2},
      {'name': playerName, 'score': playerScore},
    ];

    players.sort((a, b) => b['score'].compareTo(a['score']));

    return BaseScreen(
      showWallet: false,
      title: 'Leaderboard',
      width: 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 5),
          for (var i = 0; i < players.length; i++) ...[
            SizedBox(
              height: 65,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: players[i]['name'] == playerName
                          ? const Color(0xFF6CD8FF)
                          : const Color(0xFFFF6CD8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Row(
                      children: [
                        const SizedBox(width: 60),
                        Expanded(
                          child: Text(
                            players[i]['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          players[i]['score'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: -1,
                    top: -7,
                    child: AppButton(
                      type: AppButtonType.secondary,
                      width: 65,
                      height: 65,
                      icon: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
