import 'dart:async';

import 'package:calculator_app/views/screen_calculator.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void toNextRoute(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenCalculator(),
        ),
      );
    });
  }
}
