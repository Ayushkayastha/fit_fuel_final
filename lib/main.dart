import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


import 'core/app/calorie_counter_app.dart';
import 'features/home/step_counter/data/step_counter_local_data_source.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox<int>(StepCounterLocalDataSourceImpl.boxName);


  await Geolocator.requestPermission();

  runApp(
      ProviderScope(
          child: CalorieCounterApp()
      )
  );


}

