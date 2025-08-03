import 'package:calculator_app/customWidgets/customNoBtn.dart';
import 'package:flutter/material.dart';

class ScreenCalculator extends StatefulWidget {
  const ScreenCalculator({super.key});

  @override
  State<ScreenCalculator> createState() => _ScreenCalculatorState();
}

class _ScreenCalculatorState extends State<ScreenCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _calculator(context),
          ],
        ),
      ),
    );
  }

  Widget _calculator(BuildContext context) {
    final List<String> buttons = [
      '7',
      '8',
      '9',
      '÷',
      '4',
      '5',
      '6',
      '×',
      '1',
      '2',
      '3',
      '-',
      'C',
      '0',
      '=',
      '+'
    ];
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 30.0,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        final button = buttons[index];
        return CustomNoBtn(ontap: () {}, text: button);
      },
    );
  }
}
