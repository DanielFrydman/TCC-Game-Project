import 'package:bonfire/bonfire.dart';

class GameSpriteSheet {
  static Future<SpriteAnimation> get heroIdleLeft => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(192, 33)));

  static Future<SpriteAnimation> get heroIdleRight => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 33)));

  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(96, 33)));

  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(288, 33)));

  static Future<SpriteAnimation> get heroRunLeft => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(192.05, 64.0000999)));

  static Future<SpriteAnimation> get heroRunRight => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(-0.05, 65)));

  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(96, 64.000099)));

  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(288, 65)));

  static Future<SpriteAnimation> get readingBook => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 224)));

  static Future<SpriteAnimation> get secretary => SpriteAnimation.load(
      'map/introduction/reception/animated_receptionist_2.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 0)));

  static Future<SpriteAnimation> get book => SpriteAnimation.load(
      'characters/Premade_Character_07.png',
      SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(224, 224)));

  static Future<SpriteAnimation> get auditoriumNpcIdleLeft =>
      SpriteAnimation.load(
          'characters/Premade_Character_14.png',
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.15,
              textureSize: Vector2(16, 32),
              texturePosition: Vector2(192, 33)));

  static Future<SpriteAnimation>
      get auditoriumNpcIdleRight => SpriteAnimation.load(
          'characters/Premade_Character_14.png',
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.15,
              textureSize: Vector2(16, 32),
              texturePosition: Vector2(0, 33)));

  static Future<SpriteAnimation> get auditoriumNpcIdleUp =>
      SpriteAnimation.load(
        'characters/Premade_Character_14.png',
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.15,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(96, 33)),
      );

  static Future<SpriteAnimation> get auditoriumNpcIdleDown =>
      SpriteAnimation.load(
          'characters/Premade_Character_14.png',
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.15,
              textureSize: Vector2(16, 32),
              texturePosition: Vector2(288, 33)));

  static Future<SpriteAnimation> get auditoriumNpcRunLeft =>
      SpriteAnimation.load(
          'characters/Premade_Character_14.png',
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.15,
              textureSize: Vector2(16, 32),
              texturePosition: Vector2(192.05, 64.0000999)));

  static Future<SpriteAnimation> get auditoriumNpcRunRight =>
      SpriteAnimation.load(
          'characters/Premade_Character_14.png',
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.15,
              textureSize: Vector2(16, 32),
              texturePosition: Vector2(-0.05, 65)));

  static Future<SpriteAnimation> get auditoriumNpcRunUp => SpriteAnimation.load(
      'characters/Premade_Character_14.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(96, 64.000099)));

  static Future<SpriteAnimation> get auditoriumNpcRunDown =>
      SpriteAnimation.load(
          'characters/Premade_Character_14.png',
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.15,
              textureSize: Vector2(16, 32),
              texturePosition: Vector2(288, 65)));

  static Future<SpriteAnimation> get auditoriumTechGuy => SpriteAnimation.load(
      'characters/Premade_Character_18.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(288, 33)));

  static Future<SpriteAnimation>
      get auditoriumPenDriveGirl => SpriteAnimation.load(
          'characters/Premade_Character_06.png',
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.15,
              textureSize: Vector2(16, 32),
              texturePosition: Vector2(288, 33)));

  static Future<SpriteAnimation> get nothing => SpriteAnimation.load(
      'characters/Premade_Character_06.png',
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(0, 0),
          texturePosition: Vector2(0, 0)));

  static Future<SpriteAnimation> get fxBlueLightning => SpriteAnimation.load(
      'fxs/FX002_08.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 0)));

  static Future<SpriteAnimation> get fxFirstSmoke => SpriteAnimation.load(
      'fxs/FX002_08.png',
      SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.15,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(192, 0)));

  static Future<SpriteAnimation> get fxSecondSmoke => SpriteAnimation.load(
      'fxs/FX002_08.png',
      SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(352, 0)));

  static Future<SpriteAnimation> get firstNpcClothes => SpriteAnimation.load(
      'characters/Premade_Character_11.png',
      SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 192)));

  static Future<SpriteAnimation> get second1NpcClothes => SpriteAnimation.load(
      'characters/Premade_Character_05.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 33)));

  static Future<SpriteAnimation> get second2NpcClothes => SpriteAnimation.load(
      'characters/Premade_Character_08.png',
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(192, 33)));

  static Future<SpriteAnimation> get thirdNpcClothes => SpriteAnimation.load(
        'characters/Premade_Character_19.png',
        SpriteAnimationData.sequenced(
            amount: 12,
            stepTime: 0.15,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(0, 192)),
      );

  static Future<SpriteAnimation> get firstNpcOfficeDown => SpriteAnimation.load(
        'characters/Premade_Character_15.png',
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.15,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(288, 256)),
      );

  static Future<SpriteAnimation> get secondNpcOfficeDown =>
      SpriteAnimation.load(
        'characters/Premade_Character_20.png',
        SpriteAnimationData.sequenced(
            amount: 12,
            stepTime: 0.12,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(0, 224)),
      );

  static Future<SpriteAnimation> get thirdNpcOfficeDown => SpriteAnimation.load(
        'characters/Premade_Character_16.png',
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.15,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(288, 32)),
      );

  static Future<SpriteAnimation> get firstNpcOfficeUpRight =>
      SpriteAnimation.load(
        'characters/Premade_Character_03.png',
        SpriteAnimationData.sequenced(
            amount: 12,
            stepTime: 0.12,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(576, 288)),
      );

  static Future<SpriteAnimation> get secondNpcOfficeUpRight =>
      SpriteAnimation.load(
        'characters/Premade_Character_04.png',
        SpriteAnimationData.sequenced(
            amount: 12,
            stepTime: 0.15,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(0, 192)),
      );

  static Future<SpriteAnimation> get firstNpcOfficeUpLeft =>
      SpriteAnimation.load(
        'characters/Premade_Character_09.png',
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.15,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(288, 32)),
      );

  static Future<SpriteAnimation> get secondNpcOfficeUpLeft =>
      SpriteAnimation.load(
        'characters/Premade_Character_01.png',
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.15,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(288, 32)),
      );
}
