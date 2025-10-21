import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../services/settings_service.dart';
import 'components/player_chicken.dart';
import 'components/enemy_circle.dart';

class ChickenGame extends FlameGame with HasCollisionDetection {
  final VoidCallback onGameOver;
  late PlayerChicken player;
  final String avatarPath;
  final String selectedEgg;
  final SettingsService settings;
  double _spawnTimer = 0;
  bool isGameOver = false;
  int score = 0;
  final void Function(int score, double time, bool won)? onScoreUpdate;
  final double maxTime = 90;
  double remainingTime = 90;
  bool isWon = false;

  ChickenGame({required this.onGameOver,required this.settings, required this.onScoreUpdate, required this.avatarPath, required this.selectedEgg});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(SpriteComponent()
      ..sprite = await loadSprite('game_bg.png')
      ..size = size
      ..anchor = Anchor.topLeft);



    player = PlayerChicken(
      gameSize: size,
      avatarPath: avatarPath,
      selectedEgg: selectedEgg,
    )..priority = 1;

    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;

    _spawnTimer += dt;
    remainingTime -= dt;

    if (remainingTime <= 0) {
      remainingTime = 0;
      gameOver(won: player.isAlive);
      return;
    }

    if (_spawnTimer > 1.5) {
      _spawnTimer = 0;
      add(EnemyCircle(gameSize: size)..priority = 0);
    }
    onScoreUpdate?.call(score, remainingTime, player.isAlive);
  }

  void addScore(int points) {
    score += points;
    onScoreUpdate?.call(score, remainingTime, player.isAlive);
  }

  void gameOver({bool won = false}) {
    if (isGameOver) return;
    isGameOver = true;
    isWon = won;
    settings.updateBestScore(score);
    pauseEngine();
    onGameOver();
  }

  void resetGame() {
    isGameOver = false;
    score = 0;
    remainingTime = maxTime;

    for (final enemy in children.query<EnemyCircle>()) {
      enemy.removeFromParent();
    }

    player.isAlive = true;
    player.resetSprite();

    resumeEngine();
  }
}
