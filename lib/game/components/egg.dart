import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import '../chicken_game.dart';
import 'enemy_circle.dart';

class Egg extends SpriteComponent with CollisionCallbacks, HasGameReference<ChickenGame> {
  final Vector2 gameSize;
  final String eggAsset;
  final double speed = 300;

  Egg({required this.gameSize, required Vector2 position, required this.eggAsset})
      : super(
    size: Vector2(30, 40),
    position: position,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(eggAsset);

    add(CircleHitbox(
      radius: size.x * 0.35,
      position: size / 2,
    )..collisionType = CollisionType.active);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += speed * dt;

    if (position.y > gameSize.y + size.y) {
      removeFromParent();
    }
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is EnemyCircle) {
      removeFromParent();
      other.removeFromParent();
      game.addScore(1);
    }
  }
}
