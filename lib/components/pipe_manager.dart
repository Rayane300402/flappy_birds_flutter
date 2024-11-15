import 'dart:math';
import 'package:flame/components.dart';
import 'package:flappy_birds/components/pipe.dart';
import 'package:flappy_birds/constants.dart';
import 'package:flappy_birds/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame>{

  /*

    UPDATE

    We will continuously spawn new pipes.

  */

  double pipesSpawnTimer = 0;

  @override
  void update(double dt) {
    // generate new pipe at given interval
    pipesSpawnTimer += dt;


    if(pipesSpawnTimer > pipeInterval){
      pipesSpawnTimer = 0;
      spawnPipe();
    }
  }

  spawnPipe(){
    final double screenHeight = gameRef.size.y;

    // calculate pipe height
    final double maxPipeHeight = screenHeight - groundHeight - pipeGap - minPipeHeight;

    // height of bottom pipe
    final double bottomPipeHeight = minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    // height of top pipe
    final double topPipeHeight = screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    // CREATE BOTTOM PIPE

    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false
    );

    // CREATE TOP PIPE

    final topPipe = Pipe(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true
    );

    // add both pipes to game ref
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);

  }

}