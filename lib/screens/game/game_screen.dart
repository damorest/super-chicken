import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:media_test/core/app_router.dart';
import 'package:media_test/widgets/components/app_button.dart';
import 'package:provider/provider.dart';
import '../../game/chicken_game.dart';
import '../../services/settings_service.dart';
import '../../widgets/app_pause_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late ChickenGame game;
  bool showGameOver = false;
  bool isPaused = false;
  int bestScore = 0;

  int score = 0;
  double remainingTime = 90;

  @override
  void initState() {
    super.initState();

    final settings = context.read<SettingsService>();
    final avatar = settings.avatarPath;
    bestScore = settings.bestScore;

    game = ChickenGame(
      onGameOver: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() {
            bestScore = settings.bestScore;
            showGameOver = true;
            isPaused = false;
          });
        });
      },
      onScoreUpdate: (newScore, newTime, won) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() {
            score = newScore;
            remainingTime = newTime;
          });
        });
      },
      avatarPath: avatar,
      settings: settings,
      selectedEgg: settings.selectedEgg,
    );
  }

  void restartGame() {
    setState(() {
      showGameOver = false;
      isPaused = false;
      score = 0;
      remainingTime  = 90;
      game.resumeEngine();
      game.resetGame();
    });
  }

  void pauseGame() {
    game.pauseEngine();
    setState(() => isPaused = true);
  }

  void resumeGame() {
    game.resumeEngine();
    setState(() => isPaused = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    remainingTime.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
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
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Circle.png',
                        width: 55,
                        height: 55,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        score.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
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
                    ],
                  ),
                ),
                AppPauseButton(
                  onTap: pauseGame,
                ),
              ],
            ),
          ),
          if (isPaused)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'PAUSED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, AppRouter.home),
                            child: const Text(
                              'HOME',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          GestureDetector(
                            onTap: restartGame,
                            child: const Text(
                              'RESTART',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: resumeGame,
                        child: SizedBox(
                          width: 200,
                          height: 80,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/menu_but.png',
                                width: 200,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                              const Text(
                                'Play',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (showGameOver)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (game.isWon) ...[
                        const Text(
                          'YOU WIN!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Score: $score',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Best: $bestScore',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, AppRouter.home),
                              child: const Text(
                                'HOME',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            GestureDetector(
                              onTap: restartGame,
                              child: const Text(
                                'RESTART',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AppButton(
                          text: 'Next',
                          fontSize: 32,
                          onPressed: () {
                            final settings = context.read<SettingsService>();
                            final nextLevel = settings.currentLevel + 1;
                            settings.currentLevel = nextLevel;

                            Navigator.pushNamed(context, AppRouter.game);
                          },
                        ),
                      ] else ...[
                        const Text(
                          'YOU LOSE!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Score: $score',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Best: $bestScore',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, AppRouter.home),
                            child: const Text(
                              'HOME',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: restartGame,
                          child: SizedBox(
                            width: 200,
                            height: 80,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/menu_but.png',
                                  width: 200,
                                  height: 80,
                                  fit: BoxFit.contain,
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Try',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
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
                                    Text(
                                      'Again',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
