import 'dart:math';

import 'package:flame/components/parallax_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spacepewpew/components/bullet.dart';
import 'package:spacepewpew/components/enemy.dart';
import 'package:spacepewpew/components/game_over.dart';
import 'package:spacepewpew/components/multiplier.dart';
import 'package:spacepewpew/components/score.dart';
import 'package:spacepewpew/components/ship.dart';
import 'package:spacepewpew/main.dart';

Enemy enemy;
Ship ship = Ship();
ScoreDisplay score;
Multiplier multiplier;
GameOver gameOverMessage;

class MyGame extends BaseGame with TapDetector, HorizontalDragDetector {
  bool checkOnce = true;

  List<Enemy> enemyList = <Enemy>[];
  List<Bullet> bulletList = <Bullet>[];

  Size dimensions;

  MyGame(this.dimensions) {
    score = ScoreDisplay(this);
    multiplier = Multiplier(this);
    gameOverMessage = GameOver(this);

    add(
      ParallaxComponent(
        [
          ParallaxImage('background.png', repeat: ImageRepeat.repeat, alignment: Alignment.center),
        ],
        baseSpeed: Offset(0, -50),
      ),
    );
    add(ship);
  }

  @override
  void render(Canvas canvas) {
    score.render(canvas);
    multiplier.render(canvas);
    gameOverMessage.render(canvas);

    super.render(canvas);
  }

  double creationTimer = 0.0;
  double bulletTimer = 0.0;
  @override
  void update(double t) {
    if (!gameOver) {
      ship.update(t);
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
    }

    score.update(t);
    multiplier.update(t);
    gameOverMessage.update(t);
    super.update(t);
  }

  @override
  void onTapDown(TapDownDetails details) {
    startFiring(details.globalPosition);

    if (gameOver) {
      points = 0;
      gameOver = false;
    }
    super.onTapDown(details);
  }

  @override
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    startFiring(details.globalPosition);
    super.onHorizontalDragUpdate(details);
  }

  @override
  void onTap() {
    stopFiring();
    super.onTap();
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    stopFiring();
    super.onHorizontalDragEnd(details);
  }

  void startFiring(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;

    if (!isFiring) {
      isFiring = true;
    }
  }

  void stopFiring() {
    isFiring = false;
  }
}
