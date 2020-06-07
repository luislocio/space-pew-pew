import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:spacepewpew/components/bullet.dart';
import 'package:spacepewpew/components/enemy.dart';
import 'package:spacepewpew/my_game.dart';

bool gameOver = false;

const ENEMYSPEED = 120.0;
const BULLETSPEED = 80.0;

double enemyRepeat = 8;
double bulletRepeat = 1.0;

const ENEMY_SIZE = 40.0;
const BULLET_SIZE = 20.0;
const SHIP_SIZE = 40.0;

var points = 0;
Enemy enemy;
Bullet bullet;

var game;

bool isFiring = false;

double touchPositionDx = 0.0;
double touchPositionDy = 0.0;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.util.fullScreen();

  Flame.images.loadAll([
    'fire.png',
    'dragon1.png',
    'dragon2.png',
    'dragon3.png',
    'dragon4.png',
    'gun.png',
    'bullet.png',
    'background.png',
  ]);

  var dimensions = await Flame.util.initialDimensions();
  game = MyGame(dimensions);

  runApp(
    MaterialApp(
      theme: ThemeData(backgroundColor: Colors.blueGrey),
      home: GameWrapper(game),
    ),
  );
}

class GameWrapper extends StatelessWidget {
  final MyGame game;

  const GameWrapper(this.game);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}
