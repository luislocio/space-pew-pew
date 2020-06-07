import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import 'package:spacepewpew/main.dart';

class Ship extends SpriteComponent {
  Ship() : super.fromSprite(SHIP_SIZE, SHIP_SIZE, Sprite('gun.png'));

  @override
  void update(double t) {
    this.x = touchPositionDx - (SHIP_SIZE / 2);
    this.y = touchPositionDy - 80;
    super.update(t);
  }

  @override
  void resize(Size size) {
    this.x = size.width / 2;
    this.y = size.height / 2;
  }
}
