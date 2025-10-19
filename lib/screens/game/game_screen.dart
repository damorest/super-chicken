import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../../game/chicken_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late ChickenGame game;
  bool showGameOver = false;

  @override
  void initState() {
    super.initState();
    game = ChickenGame(
      onGameOver: () {
        setState(() {
          showGameOver = true;
        });
      },
    );
  }

  void restartGame() {
    setState(() {
      showGameOver = false;
      game.resetGame();
    });
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
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/Rectangle.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 36,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                game.pauseEngine();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.black87,
                    title: const Text(
                      'PAUSE',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          game.resumeEngine();
                        },
                        child: const Text('CONTINUE'),
                      ),
                    ],
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/Rectangle.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  const Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 36,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ],
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
                      const Text(
                        'GAME OVER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: restartGame,
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
                              'RESTART',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
