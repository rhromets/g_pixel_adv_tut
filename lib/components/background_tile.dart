import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundTile extends ParallaxComponent {
  final String color;
  BackgroundTile({
    this.color = 'Gray',
    position,
  }) : super(position: position);

  final double scrollSpeed = 40;

  @override
  Future<void> onLoad() async {
    priority = -10;

    final double cameraWidth = game.size.x;

    size = Vector2(cameraWidth, game.size.y);

    parallax = await game.loadParallax(
      [ParallaxImageData('Background/$color.png')],
      baseVelocity: Vector2(0, -scrollSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
      size: size,
    );
    return super.onLoad();
  }
}
