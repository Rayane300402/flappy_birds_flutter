import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_birds/components/background.dart';
import 'package:flappy_birds/components/bird.dart';
import 'package:flappy_birds/components/ground.dart';
import 'package:flappy_birds/components/pipe_manager.dart';
import 'package:flappy_birds/components/score.dart';
import 'package:flappy_birds/constants.dart';
import 'package:flutter/material.dart';

import 'components/pipe.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection{
  /*

  Basic Game Components:
  - bird
  - bg
  - ground
  - pipes
  - score

  */

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  /*

    LOAD

  */

@override
  FutureOr<void> onLoad() {
    // order matters, anything to the back is written first, anything to the front is written last
    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);

    ground = Ground();
    add(ground);
    
    // load pipes
    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);
  }

  /*

    TAP - Let the bird jump

  */

@override
  void onTap() {
    bird.flap();
  }

  /*

    SCORE

  */

  int score = 0;

  void incrementScore(){
    score +=1;
  }

  /*

    GAME OVER

  */

  bool isGameOver = false;

  void gameOver(){
    // prevent multiple game over triggers
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();
    
    // show game over dialog box 
    showDialog(
        context: buildContext!, 
        builder: (context) => AlertDialog(
          title: const Text("Game Over"),
          content: Text("High Score: " + score.toString()),
          actions: [
            TextButton(
                onPressed: () {
                   Navigator.pop(context);

                   // reset game
                  resetGame();
                },
                child: const Text("Restart")
            )
          ],
        )
    );
  }

  void resetGame(){
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    // remove all pipes
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }

}