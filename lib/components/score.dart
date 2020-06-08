import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:spacepewpew/main.dart';
import 'package:spacepewpew/my_game.dart';

class ScoreDisplay {
  final MyGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
    );

    painter.text = TextSpan(
      text: '',
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      -painter.width,
      -painter.height,
    );
  }

  void render(Canvas c) {
    position = Offset(
      game.size.width - painter.width - 10,
      game.size.height - painter.height - 10,
    );

    painter.paint(c, position);
  }

  void update(double t) {
    if (painter.text.text != points.toString()) {
      painter.text = TextSpan(
        text: points.toString(),
        style: textStyle,
      );

      painter.layout();

      position = Offset(
        game.dimensions.width - painter.width - 10,
        game.dimensions.height - painter.height - 10,
      );
    }
  }
}
