import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:spacepewpew/components/enemy.dart';
import 'package:spacepewpew/components/explosion.dart';
import 'package:spacepewpew/main.dart';

class Bullet extends SpriteComponent {
  bool hitAnEnemy = false;
  double maxY;
  List<Enemy> enemyList = <Enemy>[];
  List<Bullet> bulletList = <Bullet>[];

  Bullet(this.enemyList, this.bulletList) : super.fromSprite(BULLET_SIZE, BULLET_SIZE, Sprite('bullet.png'));

  @override
  void update(double t) {
    double multiplier = points / 100;
    y -= gameOver ? 0 : t * BULLETSPEED * (1 + multiplier);

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

    super.update(t);
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
    this.x = touchPositionDx - (BULLET_SIZE / 2);
    this.y = touchPositionDy - 80;
    this.maxY = size.height;
  }
}
