import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/calculator_provider.dart';
import '../../application/controllers/calculator_state.dart';
import '../../utils/theme/app_theme.dart';

class CalculatorDisplay extends ConsumerStatefulWidget {
  const CalculatorDisplay({Key? key}) : super(key: key);

  @override
  ConsumerState<CalculatorDisplay> createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends ConsumerState<CalculatorDisplay>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;
  late AnimationController _resultController;
  late Animation<double> _resultScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Shake animation controller
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _shakeAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.05, 0)).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticInOut),
    );

    // Result scale animation controller
    _resultController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _resultScaleAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _resultController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  void _triggerShake() {
    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });
  }

  void _triggerResultAnimation() {
    _resultController.forward().then((_) {
      _resultController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calculatorProvider);

    // Trigger result animation when equals is pressed
    ref.listen(calculatorProvider, (previous, next) {
      if (previous != null && next.isResult && !previous.isResult) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _triggerResultAnimation();
        });
      }
    });

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.buttonSurface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Expression row
          SizedBox(
            height: 30,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Semantics(
                liveRegion: true,
                child: Text(
                  state.expression.isEmpty ? '' : state.expression,
                  style: AppTheme.expressionStyle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Result row
          SizedBox(
            height: 80,
            child: Align(
              alignment: Alignment.centerRight,
              child: SlideTransition(
                position: _shakeAnimation,
                child: ScaleTransition(
                  scale: _resultScaleAnimation,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        state.isError ? 'Error' : state.displayNumber,
                        style: state.isError
                            ? AppTheme.errorStyle
                            : AppTheme.displayLargeStyle,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
