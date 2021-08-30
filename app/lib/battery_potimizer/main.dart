import 'package:flutter/material.dart';
import 'package:app/battery_potimizer/app_list.dart';
import 'package:app/battery_potimizer/top_buttons.dart';
import 'package:app/battery_potimizer/indicator.dart';
import 'package:app/battery_potimizer/optimize_button.dart';

const bColorPurple = Color(0xFF8337EC);
const bColorPink = Color(0xFFFF006F);
const bColorIndicatorBegin = bColorPink;
const bColorIndicatorEnd = bColorPurple;
const bColorTitle = Color(0xFF616161);
const bColorText = Color(0xFF9E9E9E);
const bElevation = 4.0;

// ignore:
class BatteryOptimizerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Battery Optimizer'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const OptimizerButtons(),
              const BatteryLevelIndicator(),
              const AppList(),
              OptimizeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
