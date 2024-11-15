import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_birds/game.dart';

import '../constants.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks{
  // init
  Ground(): super();

  @override
  FutureOr<void> onLoad() async{
    // set size + position
    size = Vector2(2*gameRef.size.x, groundHeight);
    position= Vector2(0, gameRef.size.y - groundHeight);

    // load
    sprite = await Sprite.load('ground.png');
    
    // add a collision box
    add(RectangleHitbox());
  }

  /*

    UPDATE - infinite horizontal scrolling to make it seem as if we are moving

   */

  @override
  void update(double dt) {
    // move ground to the left
    position.x -= groundScrollingSpeed * dt;

    // reset ground if it goes off screen for infinite scroll effect . i would assume tbh by gameRef.size.x you reset, so half of ground passed
    if(position.x + size.x / 2 <= 0){
      position.x = 0;
    }
  }

}