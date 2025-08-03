import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_state.freezed.dart';

@freezed
class CalculatorState with _$CalculatorState {
  const factory CalculatorState({
    required String expression,
    required String result,
  }) = _CalculatorState;
}