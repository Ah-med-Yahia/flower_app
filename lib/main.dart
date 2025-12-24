import 'package:flutter/material.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/flower_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const FlowerApp());
}
