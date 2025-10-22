import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class EnemyCircle extends SpriteComponent with CollisionCallbacks {
  final Vector2 gameSize;
  final int level;
  static final _random = Random();

  EnemyCircle({required this.gameSize, required this.level})
      : super(
    size: Vector2.all(50),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('fire_circle.png');

    add(CircleHitbox(
      radius: size.x * 0.35,
      position: size / 2,
    )..collisionType = CollisionType.passive);

    position = Vector2(
        _random.nextDouble() * (gameSize.x - size.x) + size.x / 2,
        gameSize.y + size.y / 2
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    final speed = 150 * (1 + 0.2 * (level - 1));
    position.y -= speed * dt;
    if (position.y + size.y < 0) removeFromParent();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is EnemyCircle) {
      removeFromParent();
      other.removeFromParent();
    }
  }
}
