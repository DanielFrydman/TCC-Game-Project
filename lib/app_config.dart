import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';

class AppConfig {
  static  AppConfig _instance = new AppConfig._internal();

  factory AppConfig(){
    return _instance;
  }

  AppConfig._internal();
  
  Map _config = Map();

  Future<void> load(environment) async {
    await dotenv.load(fileName: "${environment}.env");
    _config = dotenv.env;
  }

  FirebaseOptions get firebaseOptions {
    return DefaultFirebaseOptions.currentPlatform(_config);
  }

}