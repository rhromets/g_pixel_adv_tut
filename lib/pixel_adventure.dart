import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:g_pixel_adventure_tutorial/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;

  @override
  final world = Level();

  @override
  FutureOr<void> onLoad() async {
    // load all images into cache
    await images.loadAllImages();

    // await images.loadAll([
    //   'Main Characters/Ninja Frog/Idle (32x32).png',
    //   'Main Characters/Ninja Frog/Run (32x32).png',
    // ]);

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    return super.onLoad();
  }
}
