import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/app_theme.dart';

class CalcButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final int flex;
  final String semanticLabel;

  const CalcButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.flex = 1,
    this.semanticLabel = '',
  }) : super(key: key);

  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 80),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    HapticFeedback.lightImpact();
    _controller.forward().then((_) {
      _controller.reverse();
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
        widget.backgroundColor ?? AppColors.buttonSurface;
    final textColor = widget.textColor ?? AppColors.textPrimary;

    return Expanded(
      flex: widget.flex,
      child: GestureDetector(
        onTap: _onPressed,
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Semantics(
              button: true,
              label: widget.semanticLabel.isNotEmpty
                  ? widget.semanticLabel
                  : widget.label,
              onTap: _onPressed,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    widget.label,
                    style: AppTheme.buttonLabelStyle.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
