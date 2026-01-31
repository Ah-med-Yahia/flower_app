import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/bloc_observer/app_bloc_observer.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  runApp(const FlowerApp());
}
