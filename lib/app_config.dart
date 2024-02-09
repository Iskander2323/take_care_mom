import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class AppConfig {
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._();

  static final AppConfig _singleton = AppConfig._();
  //?
  static String get ENVIRONMENT => env['ENVIRONMENT'] ?? 'dev';
  static String get DEV_SCHEME => env['DEV_SCHEME'] ?? 'http';
  static String get DEV_HOST => env['DEV_HOST'] ?? '192.168.1.24:4001';

  Future<void> load() async {
    await DotEnv.load(fileName: 'assets/.env');
  }
}
