import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_birds/components/ground.dart';
import 'package:flappy_birds/components/pipe.dart';
import 'package:flappy_birds/constants.dart';
import 'package:flappy_birds/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  /*

    INIT BIRD

   */

  // init the position + size

  Bird() : super(position: Vector2(birdStartX, birdStartY), size: Vector2(birdWidth, birdHeight));

  // physical world properties
  double velocity = 0;


  /*

    LOAD

   */

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('bird.png');

    // add a hit box
    add(RectangleHitbox());
  }

  /*

    JUMP / FLAP

   */

  void flap(){
    velocity = jumpStrength;
  }

  /*

    UPDATE -> every 1 second that passes

   */

  @override
  void update(double dt){
    // apply gravity to velocity
    velocity += gravity * dt;

    // update bird's position based on current velocity
    position.y += velocity * dt;
  }

  /*

    COLLISION -> what happens when you collide with another object

  */

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // check if bird collides with the ground
    if(other is Ground){
      (parent as FlappyBirdGame).gameOver();
    }
    if(other is Pipe){
      (parent as FlappyBirdGame).gameOver();
    }
  }


}
