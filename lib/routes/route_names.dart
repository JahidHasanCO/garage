part of 'router.dart';

sealed class RouteNames {
  static String get login => 'login';
  static String get signUp => 'sign_up';
  static String get bottomNav => 'bottom_nav';
}

extension AsPathExt on String {
  String get asPath => '/$this';
}
