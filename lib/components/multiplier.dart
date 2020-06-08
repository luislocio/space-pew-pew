import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:spacepewpew/main.dart';
import 'package:spacepewpew/my_game.dart';

class Multiplier {
  final MyGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  Multiplier(this.game) {
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
      10.0,
      game.size.height - painter.height - 10,
    );

    painter.paint(c, position);
  }

  void update(double t) {
    if (painter.text.text != (1 + (points / 33)).toStringAsPrecision(3)) {
      painter.text = TextSpan(
        text: 'x' + (1 + (points / 33)).toStringAsPrecision(3),
        style: textStyle,
      );

      painter.layout();

      position = Offset(
        10.0,
        game.dimensions.height - painter.height - 10,
      );
    }
  }
}
