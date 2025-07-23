
import 'package:flutter/material.dart';

import '../../step_counter/presentation/step_counter_section.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Center(
              child: Text('Home Page', style: TextStyle(fontSize: 24)),
            ),
            StepCounterSection(),


          ],
        ),
      ),
    );
  }
}
