import 'package:example/presentation/app_root.dart';
import 'package:example/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();
  runApp(const AppRoot());
}
