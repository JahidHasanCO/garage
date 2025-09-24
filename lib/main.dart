import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/app/app.dart';
import 'package:garage/core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  AppConfig.envProd = true;
  AppConfig.baseUrl = dotenv.env['LOCAL']!;
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
