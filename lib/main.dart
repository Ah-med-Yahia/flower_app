import 'package:flutter/material.dart';

import 'config/di/di.dart';
import 'flower_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const FlowerApp());
}
