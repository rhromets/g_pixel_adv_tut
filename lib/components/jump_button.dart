import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:g_pixel_adventure_tutorial/pixel_adventure.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final margin = 40;
  // final buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    priority = 100;
    anchor = Anchor.bottomRight;
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    position = Vector2(
      game.size.x - margin,
      game.size.y - margin,
    );
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
