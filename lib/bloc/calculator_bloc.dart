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
      String expr = state.expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      final numberRegExp = RegExp(r'\d+');
      final operatorRegExp = RegExp(r'[+\-*/]');

      List<BigInt> numbers = numberRegExp
          .allMatches(expr)
          .map((e) => BigInt.parse(e.group(0)!))
          .toList();

      List<String> operators = operatorRegExp
          .allMatches(expr)
          .map((e) => e.group(0)!)
          .toList();

      if (numbers.isEmpty) {
        emit(state.copyWith(result: 'Error'));
        return;
      }

      // Step 1: Handle * and /
      for (int i = 0; i < operators.length;) {
        if (operators[i] == '*' || operators[i] == '/') {
          BigInt a = numbers[i];
          BigInt b = numbers[i + 1];
          BigInt result;

          if (operators[i] == '*') {
            result = a * b;
          } else {
            if (b == BigInt.zero) {
              emit(state.copyWith(result: 'Divide by 0'));
              return;
            }
            result = a ~/ b;
          }

          numbers
            ..removeAt(i)
            ..removeAt(i)
            ..insert(i, result);
          operators.removeAt(i);
        } else {
          i++;
        }
      }

      // Step 2: Handle + and -
      BigInt result = numbers[0];
      for (int i = 0; i < operators.length; i++) {
        BigInt next = numbers[i + 1];
        if (operators[i] == '+') result += next;
        if (operators[i] == '-') result -= next;
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
