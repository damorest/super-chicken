import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'package:media_test/game/chicken_game.dart';
import 'egg.dart';
import 'enemy_circle.dart';

class PlayerChicken extends SpriteComponent
    with DragCallbacks, CollisionCallbacks, TapCallbacks, HasGameReference<ChickenGame>  {
  final Vector2 gameSize;
  final String avatarPath;
  final String selectedEgg;
  bool isAlive = true;

  Sprite? initialSprite;
  Vector2? initialSize;

  PlayerChicken({required this.gameSize, required this.avatarPath, required this.selectedEgg})
      : super(size: Vector2(60, 100), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Sprite loadedSprite;
    try {
      loadedSprite = await Sprite.load(avatarPath);
    } catch (_) {
      loadedSprite = await Sprite.load('default_chicken.png');
    }

    sprite = loadedSprite;

    final originalSize = loadedSprite.srcSize; // Vector2
    const targetHeight = 100.0;
    final targetWidth = targetHeight * (originalSize.x / originalSize.y);

    size = Vector2(targetWidth, targetHeight);
    position = Vector2(gameSize.x / 2, 170);

    initialSprite = loadedSprite;
    initialSize = size.clone();

    add(CircleHitbox(
      radius: size.x * 0.4,
      position: size / 2,
    )..collisionType = CollisionType.active);
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
      eggAsset: selectedEgg
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
    if (initialSprite != null && initialSize != null) {
      sprite = initialSprite;
      size = initialSize!.clone();
      isAlive = true;
    }
  }
}
