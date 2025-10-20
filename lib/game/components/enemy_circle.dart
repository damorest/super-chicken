import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class EnemyCircle extends SpriteComponent with CollisionCallbacks {
  final Vector2 gameSize;
  static final _random = Random();

  EnemyCircle({required this.gameSize})
      : super(
    size: Vector2.all(50),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('fire_circle.png');

    add(CircleHitbox()..collisionType = CollisionType.passive);

    position = Vector2(_random.nextDouble() * gameSize.x, gameSize.y + size.y);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= 150 * dt;
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
