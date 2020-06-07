import 'dart:math';

import 'package:flame/anchor.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:spacepewpew/components/bullet.dart';
import 'package:spacepewpew/components/enemy.dart';
import 'package:spacepewpew/components/ship.dart';
import 'package:spacepewpew/main.dart';

Enemy enemy;
Ship ship = Ship();

class MyGame extends BaseGame with TapDetector, HorizontalDragDetector {
  bool checkOnce = true;

  List<Enemy> enemyList = <Enemy>[];
  List<Bullet> bulletList = <Bullet>[];

  Size dimensions;

  MyGame(this.dimensions) {
    add(ParallaxComponent([ParallaxImage('background.png')]));
    add(ship);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    TextConfig config = TextConfig(color: Colors.white, fontSize: 48);

    if (gameOver) {
      add(TextComponent("Game Over", config: config)
        ..anchor = Anchor.center
        ..x = size.width / 2
        ..y = size.height / 2);
    } else {
      add(TextComponent(points.toString(), config: config)
        ..anchor = Anchor.bottomLeft
        ..x = 10.0
        ..y = size.height - 10);

      add(TextComponent('x' + (1 + points / 100).toString(), config: config)
        ..anchor = Anchor.bottomRight
        ..x = size.width - 10
        ..y = size.height - 10);
    }
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

    super.update(t);
  }

  @override
  void onTapDown(TapDownDetails details) {
    startFiring(details.globalPosition);
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
