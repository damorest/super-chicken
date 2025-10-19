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

  ChickenGame({required this.onGameOver});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(SpriteComponent()
      ..sprite = await loadSprite('game_bg.png')
      ..size = size
      ..anchor = Anchor.topLeft);

    player = PlayerChicken(
      gameSize: size,
      onGameOver: onGameOver,
    )..priority = 1;

    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;

    _spawnTimer += dt;
    if (_spawnTimer > 1.5) {
      _spawnTimer = 0;
      add(EnemyCircle(gameSize: size)..priority = 0);
    }
  }

  void resetGame() {
    isGameOver = false;

    for (final enemy in children.query<EnemyCircle>()) {
      enemy.removeFromParent();
    }

    player.isAlive = true;
    player.resetSprite();

    resumeEngine();
  }
}
