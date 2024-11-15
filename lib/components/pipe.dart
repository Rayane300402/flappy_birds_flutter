import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_birds/constants.dart';
import 'package:flappy_birds/game.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  // determine if pipe is to or bottom
  final bool isTopPipe;

  // score
  bool scored = false;

  // init
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe}) : super(position: position, size: size);

  /*

    LOAD

  */

@override
  FutureOr<void> onLoad() async{
    // load sprite
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    // add hit box
  add(RectangleHitbox());

  }

  /*

    LOAD

  */
  @override
  void update(double dt) {
    // scroll pipe to left
    position.x -= groundScrollingSpeed * dt;

    // check if bird passed the pipe
    if (!scored && position.x + size.x < gameRef.bird.position.x){
      scored = true;

      if(isTopPipe){
        gameRef.incrementScore();
      }
    }

    // remove pipe if it goes off the screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}