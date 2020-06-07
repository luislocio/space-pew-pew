import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:spacepewpew/main.dart';

class Enemy extends SpriteComponent {
  Size dimensions;
  int xPosition;
  int yPosition = 0;
  bool wasHit = false;
  double maxY;

  Enemy(this.dimensions, this.xPosition) : super.fromSprite(ENEMY_SIZE, ENEMY_SIZE, Sprite('dragon1.png'));

  @override
  void update(double t) {
    y += gameOver ? 0 : t * ENEMYSPEED;
    super.update(t);
  }

  @override
  bool destroy() {
    if (wasHit) {
      return true;
    }

    if (yPosition == null || maxY == null) {
      return false;
    }

    bool destroy = y >= maxY + ENEMY_SIZE;

    // TODO: HABILITAR GAME OVER
    if (destroy) {
      /* gameOver = true; */

      return true;
    }

    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = xPosition.toDouble();
    this.y = ENEMY_SIZE * yPosition;
    this.maxY = size.height;
  }
}
