import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'core/app/calorie_counter_app.dart';
void main() async {


  runApp(
      ProviderScope(
          child: CalorieCounterApp()
      )
  );


}

