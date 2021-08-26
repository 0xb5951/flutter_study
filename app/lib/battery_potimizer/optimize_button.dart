import 'package:flutter/material.dart';
import 'package:app/battery_potimizer/main.dart';

class OptimizeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Optimize Now',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: bColorPurple,
          elevation: bElevation,
          padding: EdgeInsets.symmetric(horizontal: 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
