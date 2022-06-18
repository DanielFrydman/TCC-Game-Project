import 'package:bonfire/bonfire.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';

class GameHero extends SimplePlayer with ObjectCollision {
  final direction = Direction.up;

  GameHero(Vector2 position, direction)
      : super(
          position: position, //required
          size: Vector2(16, 32), //required
          life: 100,
          speed: 50,
          initDirection: direction,
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
    if (event.event == ActionEvent.DOWN && event.id == 1) {
      _executeAtack();
    }
    super.joystickAction(event);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    super.joystickChangeDirectional(event);
  }

  void _executeAtack() {
    simpleAttackMelee(damage: 1, size: Vector2(16, 16), sizePush: 0);
  }
}
