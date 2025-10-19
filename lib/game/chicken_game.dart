import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'components/player_chicken.dart';
import 'components/enemy_circle.dart';

class ChickenGame extends FlameGame with HasCollisionDetection {
  final VoidCallback onGameOver;
  late PlayerChicken player;
  double _spawnTimer = 0;
  bool isGameOver = false;
  int score = 0;
  double elapsedTime = 0;
  final void Function(int score, double time, bool won)? onScoreUpdate;
  final double maxTime = 90;
  bool isWon = false;

  ChickenGame({required this.onGameOver, required this.onScoreUpdate});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(SpriteComponent()
      ..sprite = await loadSprite('game_bg.png')
      ..size = size
      ..anchor = Anchor.topLeft);

    player = PlayerChicken(
      gameSize: size,
    )..priority = 1;

    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;

    _spawnTimer += dt;
    elapsedTime += dt;

    if (elapsedTime >= maxTime) {
      gameOver(won: player.isAlive);
      return;
    }

    if (_spawnTimer > 1.5) {
      _spawnTimer = 0;
      add(EnemyCircle(gameSize: size)..priority = 0);
    }
    onScoreUpdate?.call(score, elapsedTime, player.isAlive);
  }

  void addScore(int points) {
    score += points;
    onScoreUpdate?.call(score, elapsedTime, player.isAlive);
  }

  void gameOver({bool won = false}) {
    if (isGameOver) return;
    isGameOver = true;
    isWon = won;
    pauseEngine();
    onGameOver();
  }

  void resetGame() {
    isGameOver = false;
    score = 0;
    elapsedTime = 0;

    for (final enemy in children.query<EnemyCircle>()) {
      enemy.removeFromParent();
    }

    player.isAlive = true;
    player.resetSprite();

    resumeEngine();
  }
}
