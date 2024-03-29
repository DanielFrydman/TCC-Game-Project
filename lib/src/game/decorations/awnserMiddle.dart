import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game/sprite_sheets/game_sprite_sheet.dart';
import 'package:game_template/src/player_progress/player_progress.dart';
import 'package:game_template/src/shared/cloud_firebase_methods.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AwnserMiddle extends SimpleEnemy {
  final String rightAwnser;
  final String wrongAwnser;
  final int awnser;
  final int awnserRecord = 3;
  final int world;
  final String rightAwnserBonus;
  final int bonusAwnser;
  final String herosName;
  final String question;

  AwnserMiddle(
      Vector2 position,
      this.world,
      this.rightAwnser,
      this.wrongAwnser,
      this.awnser,
      this.rightAwnserBonus,
      this.bonusAwnser,
      this.herosName,
      this.question)
      : super(
            position: position,
            size: Vector2(45, 28),
            animation: SimpleDirectionAnimation(
                idleRight: GameSpriteSheet.nothing,
                runRight: GameSpriteSheet.nothing),
            life: 1000);

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void receiveDamage(attacker, damage, from) {
    if (awnserRecord == awnser) {
      animation?.playOnce(GameSpriteSheet.fxBlueLightning);
      _showRightAwnserDialog(this);
    } else if (awnserRecord == bonusAwnser) {
      animation?.playOnce(GameSpriteSheet.fxBlueLightning);
      _showBonusAwnserDialog(this);
    } else {
      animation?.playOnce(GameSpriteSheet.fxFirstSmoke);
      _showWrongAwnserDialog(this);
    }
    super.receiveDamage(attacker, damage, from);
  }

  void _showBonusAwnserDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 2.2, finish: () {
      TalkDialog.show(context, [
        Say(
            text: [
              const TextSpan(text: 'Caramba '),
              TextSpan(
                  text: '${this.herosName}',
                  style: TextStyle(color: Colors.purpleAccent)),
              const TextSpan(text: '!')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [TextSpan(text: this.rightAwnserBonus)],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              TextSpan(
                  text:
                      'Você concluiu esse mundo! Vá para o próximo e continue os estudos.')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
      ], onClose: () {
        gameRef.camera.moveToPlayerAnimated(zoom: 2);
      }, onFinish: () {
        updateHistoryFromUser(
            world: this.world,
            question: this.question,
            result: 'correct with bonus');

        _goNextStage();
      });
    });
  }

  void _showRightAwnserDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 2.2, finish: () {
      TalkDialog.show(context, [
        Say(
            text: [
              const TextSpan(text: 'Muito bom hein '),
              TextSpan(
                  text: '${this.herosName}',
                  style: TextStyle(color: Colors.purpleAccent)),
              const TextSpan(text: '!')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [TextSpan(text: this.rightAwnser)],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              TextSpan(
                  text:
                      'Você concluiu esse mundo! Vá para o próximo e continue os estudos.')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
      ], onClose: () {
        gameRef.camera.moveToPlayerAnimated(zoom: 2);
      }, onFinish: () {
        updateHistoryFromUser(
            world: this.world, question: this.question, result: 'correct');

        _goNextStage();
      });
    });
  }

  void _showWrongAwnserDialog(GameComponent first) {
    gameRef.camera.moveToTargetAnimated(first, zoom: 2.2, finish: () {
      TalkDialog.show(context, [
        Say(
            text: [
              const TextSpan(text: 'Poxa '),
              TextSpan(
                  text: '${this.herosName}',
                  style: TextStyle(color: Colors.purpleAccent)),
              const TextSpan(text: '... que pena...')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [TextSpan(text: this.wrongAwnser)],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
        Say(
            text: [
              TextSpan(
                  text:
                      'Você concluiu esse mundo! Vá para o próximo e continue os estudos.')
            ],
            person: SizedBox(
              height: 100,
              width: 100,
              child: GameSpriteSheet.auditoriumNpcIdleDown.asWidget(),
            ),
            personSayDirection: PersonSayDirection.RIGHT),
      ], onClose: () {
        gameRef.camera.moveToPlayerAnimated(zoom: 2);
      }, onFinish: () {
        updateHistoryFromUser(
            world: this.world, question: this.question, result: 'wrong');

        _goNextStage();
      });
    });
  }

  void _goNextStage() {
    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(this.world);
    GoRouter.of(context).go('/menu/play');
  }
}
