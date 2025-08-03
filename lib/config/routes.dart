import 'package:calculator_app/config/routenames.dart';
import 'package:calculator_app/views/screen_calculator.dart';
import 'package:calculator_app/views/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.calculatorScreen:
        return MaterialPageRoute(
          builder: (context) => const ScreenCalculator(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text(
                  "Route Not Found",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            );
          },
        );
    }
  }
}
