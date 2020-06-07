import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/main.dart';

class Enemy extends SpriteComponent {
  Size dimensions;
  int xPosition;
  int yPosition = 0;
  bool wasHit = false;
  double maxY;

  Enemy(this.dimensions, this.xPosition) : super.rectangle(ENEMY_SIZE, ENEMY_SIZE, 'dragon1.png');

  @override
  void update(double t) {
    y += gameOver ? 0 : t * ENEMYSPEED;
  }

  @override
  bool destroy() {
    if (wasHit) {
      return true;
    }

    if (yPosition == null || maxY == null) {
      return false;
    }

    bool destroy = y >= maxY + ENEMY_SIZE * 2;

    if (destroy) {
      gameOver = true;
      print("Game Over");
      return true;
    }

    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = ENEMY_SIZE / xPosition;
    this.y = ENEMY_SIZE * yPosition;
    this.maxY = size.height;
  }
}
