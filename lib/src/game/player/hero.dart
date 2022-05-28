import 'package:bonfire/bonfire.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class GameHero extends SimplePlayer with ObjectCollision {
  GameHero(Vector2 position)
      : super(
          position: position, //required
          size: Vector2(16, 32), //required
          life: 100,
          speed: 50,
          initDirection: Direction.up,
          animation: SimpleDirectionAnimation(
            idleLeft: GameSpriteSheet.heroIdleLeft,
            idleRight: GameSpriteSheet.heroIdleRight, //required
            runLeft: GameSpriteSheet.heroRunLeft,
            runRight: GameSpriteSheet.heroRunRight, //required
            idleUp: GameSpriteSheet.idleUp,
            idleDown: GameSpriteSheet.idleDown,
            runUp: GameSpriteSheet.runUp,
            runDown: GameSpriteSheet.runDown,
          ), //required
        ) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(size: Vector2(10, 8), align: Vector2(3, 24))
    ]));
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.id == 1) {
      print('ativar computador');
    }
    super.joystickAction(event);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    super.joystickChangeDirectional(event);
  }
}
