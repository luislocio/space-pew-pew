import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:spacepewpew/main.dart';
import 'package:spacepewpew/my_game.dart';

class GameOver {
  final MyGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  GameOver(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Colors.transparent,
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
      (game.dimensions.width - painter.width) / 2,
      (game.dimensions.height - painter.height) / 2,
    );

    painter.paint(c, position);
  }

  void update(double t) {
    textStyle = TextStyle(
      color: gameOver ? Colors.white : Colors.transparent,
      fontSize: 30,
    );

    painter.text = TextSpan(
      text: 'GAME OVER\n\n Toque na tela\npara tentar novamente!',
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      (game.dimensions.width - painter.width) / 2,
      (game.dimensions.height - painter.height) / 2,
    );
  }
}
