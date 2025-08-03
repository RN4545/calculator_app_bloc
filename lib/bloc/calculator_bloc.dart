import 'package:bloc/bloc.dart';
import 'package:calculator_app/bloc/calculator_event.dart';
import 'package:calculator_app/bloc/calculator_state.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc()
      : super(
          const CalculatorState(expression: '', result: ''),
        ) {
    on<NumberPressed>(_numberPressed);
    on<OperatorPressed>(_operatorPressed);
    on<ClearPressed>(_clearPressed);
    on<CalculateResult>(_calculateResult);
  }

  void _numberPressed(NumberPressed event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(expression: state.expression + '${event.number}'));
  }

  void _operatorPressed(OperatorPressed event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(expression: state.expression + '${event.operator}'));
  }

  void _clearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    emit(const CalculatorState(expression: '', result: ''));
  }
  void _calculateResult(CalculateResult event, Emitter<CalculatorState> emit) {
    try {
      String finalExpression = state.expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      final numberRegExp = RegExp(r'\d+');
      final operatorRegExp = RegExp(r'[+\-*/]');

      final numbers = numberRegExp
          .allMatches(finalExpression)
          .map((e) => BigInt.parse(e.group(0)!))
          .toList();

      final operators = operatorRegExp
          .allMatches(finalExpression)
          .map((e) => e.group(0)!)
          .toList();

      if (numbers.isEmpty) {
        emit(state.copyWith(result: 'Error'));
        return;
      }

      BigInt result = numbers[0];
      for (int i = 0; i < operators.length; i++) {
        final op = operators[i];
        final num = numbers[i + 1];

        if (op == '+') result += num;
        else if (op == '-') result -= num;
        else if (op == '*') result *= num;
        else if (op == '/') result = result ~/ num;
      }

      emit(state.copyWith(result: result.toString()));
    } catch (e) {
      emit(state.copyWith(result: 'Error'));
    }
  }


// void _calculateResult(CalculateResult event, Emitter<CalculatorState> emit) {
  //   try {
  //     final expression =
  //         state.expression.replaceAll('x', '*').replaceAll('÷', '/');
  //     final parser = Parser();
  //     final parsedExpression = parser.parse(expression);
  //     final contextModel = ContextModel();
  //     final double result =
  //         parsedExpression.evaluate(EvaluationType.REAL, contextModel);
  //     emit(
  //       state.copyWith(
  //         result: result.toString(),
  //       ),
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(result: 'Error'));
  //   }
  // }
}
