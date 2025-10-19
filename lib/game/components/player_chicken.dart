import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'package:media_test/game/chicken_game.dart';
import 'egg.dart';
import 'enemy_circle.dart';

class PlayerChicken extends SpriteComponent
    with DragCallbacks, CollisionCallbacks, TapCallbacks, HasGameReference<ChickenGame>  {
  final Vector2 gameSize;
  bool isAlive = true;
  late final Sprite initialSprite;

  PlayerChicken({required this.gameSize})
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

  @override
  void onTapDown(TapDownEvent event) {
    if (isAlive) {
      dropEgg();
    }
    super.onTapDown(event);
  }

  void dropEgg() {
    final egg = Egg(
      gameSize: gameSize,
      position: Vector2(position.x, position.y + size.y / 2),
    );
    parent?.add(egg);
  }

  Future<void> _burnChicken() async {
    final burnedSprite = await Sprite.load('end.png');

    sprite = burnedSprite;

    await Future.delayed(const Duration(milliseconds: 50));

    game.gameOver();
  }


  void resetSprite() {
    sprite = initialSprite;
    isAlive = true;
  }
}
