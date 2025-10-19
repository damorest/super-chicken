import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'enemy_circle.dart';

class PlayerChicken extends SpriteComponent
    with DragCallbacks, CollisionCallbacks {
  final Vector2 gameSize;
  final VoidCallback onGameOver;
  bool isAlive = true;
  late final Sprite initialSprite;

  PlayerChicken({required this.gameSize, required this.onGameOver})
      : super(size: Vector2(100, 100), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    initialSprite = await Sprite.load('chicken.png');
    sprite = initialSprite;
    position = Vector2(gameSize.x / 2, 170);

    add(RectangleHitbox());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final deltaX = event.localEndPosition.x - event.localStartPosition.x;
    position.x += deltaX;
    position.x = position.x.clamp(size.x / 2, gameSize.x - size.x / 2);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is EnemyCircle && isAlive) {
      isAlive = false;

      _burnChicken();

      other.removeFromParent();
    }
  }

  Future<void> _burnChicken() async {
    sprite = await Sprite.load('end.png');

    Future.delayed(const Duration(milliseconds: 50), onGameOver);
  }

  void resetSprite() {
    sprite = initialSprite;
    isAlive = true;
  }
}
