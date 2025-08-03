import 'package:calculator_app/bloc/calculator_bloc.dart';
import 'package:calculator_app/bloc/calculator_event.dart';
import 'package:calculator_app/bloc/calculator_state.dart';
import 'package:calculator_app/customWidgets/customNoBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCalculator extends StatelessWidget {
  const ScreenCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorBloc(),
      child: const CalculatorUI(),
    );
  }
}

class CalculatorUI extends StatelessWidget {
  const CalculatorUI({super.key});

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
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _display(),
            const SizedBox(height: 20.0),
            _calculatorButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _display() {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                state.expression,
                style: const TextStyle(fontSize: 20.0,color: Colors.black),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                state.result,
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.bold,color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _calculatorButtons(BuildContext context) {
    final List<String> buttons = [
      '7', '8', '9', '÷',
      '4', '5', '6', '×',
      '1', '2', '3', '-',
      'C', '0', '=', '+'
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 30.0,
      ),
      itemBuilder: (context, index) {
        final button = buttons[index];

        return CustomNoBtn(
          text: button,
          ontap: () {
            final bloc = context.read<CalculatorBloc>();

            if (button == 'C') {
              bloc.add(const ClearPressed());
            } else if (button == '=') {
              bloc.add(const CalculateResult());
            } else if ('÷×+-'.contains(button)) {
              bloc.add(OperatorPressed(button));
            } else {
              bloc.add(NumberPressed(button));
            }
          },
        );
      },
    );
  }
}
