import 'package:flame/components/animation_component.dart';
import 'package:galaxygame/components/enemy.dart';
import 'package:galaxygame/main.dart';

class Explosion extends AnimationComponent {
  static const TIME = 0.75;

  Explosion(Enemy enemy)
      : super.sequenced(
          ENEMY_SIZE,
          ENEMY_SIZE,
          'fire.png',
          7,
          textureWidth: 31,
          textureHeight: 31.0,
        ) {
    this.x = enemy.x;
    this.y = enemy.y;
    this.animation.stepTime = TIME / 7;
  }

  bool destroy() {
    return this.animation.isLastFrame;
  }
}
