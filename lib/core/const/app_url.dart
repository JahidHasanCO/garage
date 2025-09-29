import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrl {
  AppUrl._();
  static String login = '${dotenv.env['LOGIN']}';
  static String services = '${dotenv.env['SERVICES']}';
}
