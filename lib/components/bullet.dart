import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/components/enemy.dart';
import 'package:galaxygame/components/explosion.dart';
import 'package:galaxygame/main.dart';

class Bullet extends SpriteComponent {
  bool hitAnEnemy = false;
  double maxY;
  List<Enemy> enemyList = <Enemy>[];
  List<Bullet> bulletList = <Bullet>[];

  Bullet(this.enemyList, this.bulletList) : super.square(BULLET_SIZE, 'bullet.png');

  @override
  void update(double t) {
    y -= gameOver ? 0 : t * BULLETSPEED;

    Enemy hitEnemy;

    if (enemyList.isNotEmpty) {
      enemyList.forEach((enemy) {
        bool enemyWasHit = this.toRect().contains(enemy.toRect().bottomLeft) ||
            this.toRect().contains(enemy.toRect().bottomCenter) ||
            this.toRect().contains(enemy.toRect().bottomRight);

        if (enemyWasHit) {
          points += 1;

          enemy.wasHit = true;
          this.hitAnEnemy = true;

          hitEnemy = enemy;
        }
      });
    }

    if (hitEnemy != null) {
      enemyList.remove(hitEnemy);
      game.add(Explosion(hitEnemy));
      bulletRepeat *= 0.98;
    }
  }

  @override
  bool destroy() {
    if (hitAnEnemy) {
      return true;
    }

    if (y == null || maxY == null) {
      return false;
    }

    bool destroy = y >= maxY;

    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = touchPositionDx;
    this.y = touchPositionDy;
    this.maxY = size.height;
  }
}
