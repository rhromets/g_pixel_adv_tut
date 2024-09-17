import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:g_pixel_adventure_tutorial/actors/player.dart';

class Level extends World {
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));

    add(level);
    add(
      Player(
        character: 'Ninja Frog',
      ),
    );

    return super.onLoad();
  }
}
