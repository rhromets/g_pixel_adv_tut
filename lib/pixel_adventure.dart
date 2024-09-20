import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:g_pixel_adventure_tutorial/components/player.dart';
import 'package:g_pixel_adventure_tutorial/components/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  late HudButtonComponent jumpBtn;
  bool showJoystick = true;

  @override
  FutureOr<void> onLoad() async {
    // load all images into cache
    await images.loadAllImages();

    final world = Level(
      levelName: 'Level-01',
      player: player,
    );

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    cam.priority = 1;

    addAll([cam, world]);

    if (showJoystick) {
      addJoystick();
      addJumpBtn();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      priority: 100,
      knobRadius: 35,
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
      anchor: Anchor.bottomLeft,
    );

    add(joystick);
  }

  void addJumpBtn() {
    jumpBtn = HudButtonComponent(
      anchor: Anchor.bottomRight,
      priority: 100,
      margin: const EdgeInsets.only(right: 40, bottom: 40),
      button: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
        size: Vector2(64, 64),
      ),
      onPressed: () {
        if (player.isOnGround) {
          player.performJump();
        }
      },
    );

    add(jumpBtn);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }
}
