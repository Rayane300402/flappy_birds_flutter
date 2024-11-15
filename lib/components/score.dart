import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flappy_birds/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame>{
  
  ScoreText() : super(
    text: '0',
    textRenderer: TextPaint(
      style: TextStyle(
        color: Colors.grey.shade900,
        fontSize: 48
      )
    )
  );
  
  @override
  FutureOr<void> onLoad() async{
    // set the position to lower middle
    position = Vector2(
      // center horizontally
      (gameRef.size.x - size.x) /2,
      //slightly above the bottom
      gameRef.size.y - size.y - 50
    );
  }

  @override
  void update(double dt) {
    final newText = gameRef.score.toString();
    if(text != newText){
      text = newText;
    }
  }
  
}