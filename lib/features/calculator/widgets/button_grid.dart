import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/calculator_provider.dart';
import '../provider/calculator_notifier.dart';
import '../../../theme/app_theme.dart';
import 'calc_button.dart';

class ButtonGrid extends ConsumerWidget {
  const ButtonGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(calculatorProvider.notifier);
    final state = ref.watch(calculatorProvider);
    
    // Determine AC/C label based on state
    final acLabel = state.isEmpty ? 'AC' : 'C';

    return RepaintBoundary(
      child: Column(
        children: [
          // Row 1: AC/C, +/-, %, ÷
          _buildButtonRow(
            context,
            [
              _ButtonConfig(
                label: acLabel,
                onPressed: () => notifier.clear(),
                backgroundColor: AppColors.accentGray,
                semanticLabel: acLabel == 'AC' ? 'clear all' : 'clear',
              ),
              _ButtonConfig(
                label: '+/−',
                onPressed: () => notifier.toggleSign(),
                backgroundColor: AppColors.accentGray,
                semanticLabel: 'toggle sign',
              ),
              _ButtonConfig(
                label: '%',
                onPressed: () => notifier.inputPercent(),
                backgroundColor: AppColors.accentGray,
                semanticLabel: 'percent',
              ),
              _ButtonConfig(
                label: '÷',
                onPressed: () => notifier.inputOperator('÷'),
                backgroundColor: AppColors.operatorColor,
                semanticLabel: 'divide operator',
              ),
            ],
          ),
          // Row 2: 7, 8, 9, ×
          _buildButtonRow(
            context,
            [
              _ButtonConfig(
                label: '7',
                onPressed: () => notifier.inputDigit('7'),
                semanticLabel: 'seven',
              ),
              _ButtonConfig(
                label: '8',
                onPressed: () => notifier.inputDigit('8'),
                semanticLabel: 'eight',
              ),
              _ButtonConfig(
                label: '9',
                onPressed: () => notifier.inputDigit('9'),
                semanticLabel: 'nine',
              ),
              _ButtonConfig(
                label: '×',
                onPressed: () => notifier.inputOperator('×'),
                backgroundColor: AppColors.operatorColor,
                semanticLabel: 'multiply operator',
              ),
            ],
          ),
          // Row 3: 4, 5, 6, −
          _buildButtonRow(
            context,
            [
              _ButtonConfig(
                label: '4',
                onPressed: () => notifier.inputDigit('4'),
                semanticLabel: 'four',
              ),
              _ButtonConfig(
                label: '5',
                onPressed: () => notifier.inputDigit('5'),
                semanticLabel: 'five',
              ),
              _ButtonConfig(
                label: '6',
                onPressed: () => notifier.inputDigit('6'),
                semanticLabel: 'six',
              ),
              _ButtonConfig(
                label: '−',
                onPressed: () => notifier.inputOperator('−'),
                backgroundColor: AppColors.operatorColor,
                semanticLabel: 'subtract operator',
              ),
            ],
          ),
          // Row 4: 1, 2, 3, +
          _buildButtonRow(
            context,
            [
              _ButtonConfig(
                label: '1',
                onPressed: () => notifier.inputDigit('1'),
                semanticLabel: 'one',
              ),
              _ButtonConfig(
                label: '2',
                onPressed: () => notifier.inputDigit('2'),
                semanticLabel: 'two',
              ),
              _ButtonConfig(
                label: '3',
                onPressed: () => notifier.inputDigit('3'),
                semanticLabel: 'three',
              ),
              _ButtonConfig(
                label: '+',
                onPressed: () => notifier.inputOperator('+'),
                backgroundColor: AppColors.operatorColor,
                semanticLabel: 'plus operator',
              ),
            ],
          ),
          // Row 5: 0 (2-wide), ., =
          _buildBottomRow(context, notifier),
        ],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, List<_ButtonConfig> configs) {
    return Expanded(
      child: Row(
        children: configs
            .map((config) => _buildButton(context, config))
            .toList(),
      ),
    );
  }

  Widget _buildButton(BuildContext context, _ButtonConfig config) {
    return CalcButton(
      label: config.label,
      onPressed: config.onPressed,
      backgroundColor:
          config.backgroundColor ?? AppColors.buttonSurface,
      textColor: config.textColor ?? AppColors.textPrimary,
      semanticLabel: config.semanticLabel,
    );
  }

  Widget _buildBottomRow(
    BuildContext context,
    CalculatorNotifier notifier,
  ) {
    return Expanded(
      child: Row(
        children: [
          // Backspace button
          CalcButton(
            label: '⌫',
            onPressed: () => notifier.backspace(),
            semanticLabel: 'backspace',
          ),
          // 0 button
          CalcButton(
            label: '0',
            onPressed: () => notifier.inputDigit('0'),
            semanticLabel: 'zero',
          ),
          // Decimal button
          CalcButton(
            label: '.',
            onPressed: () => notifier.inputDecimal(),
            semanticLabel: 'decimal point',
          ),
          // Equals button
          CalcButton(
            label: '=',
            onPressed: () => notifier.evaluate(),
            backgroundColor: AppColors.operatorColor,
            semanticLabel: 'equals',
          ),
        ],
      ),
    );
  }
}

class _ButtonConfig {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String semanticLabel;

  _ButtonConfig({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.semanticLabel = '',
  });
}
