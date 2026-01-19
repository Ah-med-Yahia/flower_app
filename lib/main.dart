import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const FlowerApp());
}
