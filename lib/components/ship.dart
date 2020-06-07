import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/main.dart';

class Ship extends SpriteComponent {
  @override
  void update(double t) {
    if (t == 0) {
      game.add(Ship());
    }
  }

  @override
  void resize(Size size) {
    this.x = touchPositionDx;
    this.y = touchPositionDy;
  }
}
