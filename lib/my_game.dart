import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxygame/components/bullet.dart';
import 'package:galaxygame/components/enemy.dart';
import 'package:galaxygame/components/ship.dart';
import 'package:galaxygame/main.dart';

Enemy enemy;
Ship ship;

class MyGame extends BaseGame {
  bool checkOnce = true;

  List<Enemy> enemyList = <Enemy>[];
  List<Bullet> bulletList = <Bullet>[];

  Size dimensions;

  MyGame(this.dimensions);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String score = points.toString();
    TextPainter scorePainter = Flame.util.text(score, color: Colors.white, fontSize: 48);

    String gameOverMessage = "Game Over";
    TextPainter gameOverPainter = Flame.util.text(gameOverMessage, color: Colors.white, fontSize: 48);

    gameOver
        ? gameOverPainter.paint(
            canvas,
            Offset((size.width - gameOverPainter.width) / 2, (size.height - gameOverPainter.height) / 2),
          )
        : scorePainter.paint(
            canvas,
            Offset(size.width - scorePainter.width - 10, size.height - scorePainter.height - 10),
          );
  }

  double creationTimer = 0.0;
  double bulletTimer = 0.0;

  @override
  void update(double t) {
    creationTimer += t;
    bulletTimer += t;

    if (creationTimer >= (enemyRepeat - (points / 100))) {
      creationTimer = 0.0;

      enemy = Enemy(dimensions, Random().nextInt(size.width.floor()));
      enemyList.add(enemy);
      add(enemy);
    }

    if (isFiring && bulletTimer >= bulletRepeat) {
      bulletTimer = 0;

      bulletList.add(bullet);
      bullet = Bullet(enemyList, bulletList);
      add(bullet);
    }

    super.update(t);
  }

  void startFiring(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    isFiring = true;
  }

  void stopFiring() {
    isFiring = false;
  }
}
