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
      final expression =
          state.expression.replaceAll('x', '*').replaceAll('÷', '/');
      final parser = Parser();
      final parsedExpression = parser.parse(expression);
      final contextModel = ContextModel();
      final double result =
          parsedExpression.evaluate(EvaluationType.REAL, contextModel);
      emit(
        state.copyWith(
          result: result.toString(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(result: 'Error'));
    }
  }
}
