import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galaxygame/components/bullet.dart';
import 'package:galaxygame/components/enemy.dart';
import 'package:galaxygame/my_game.dart';

bool gameOver = false;

const ENEMYSPEED = 120.0;
const BULLETSPEED = 60.0;

double enemyRepeat = 10;
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

  Flame.images
      .loadAll(['fire.png', 'dragon1.png', 'dragon2.png', 'dragon3.png', 'dragon4.png', 'gun.png', 'bullet.png']);

  var dimensions = await Flame.util.initialDimensions();
  game = MyGame(dimensions);

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: GameWrapper(game),
        ),
      ),
    ),
  );

  Flame.util.addGestureRecognizer(HorizontalDragGestureRecognizer()
    ..onUpdate = (startDetails) {
      game.startFiring(startDetails.globalPosition);
    }
    ..onEnd = (endDetails) {
      game.stopFiring();
    });

  Flame.util.addGestureRecognizer(TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) {
      game.startFiring(evt.globalPosition);
    }
    ..onTap = () {
      game.stopFiring();
    });
}

class GameWrapper extends StatelessWidget {
  final MyGame game;

  const GameWrapper(this.game);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}
