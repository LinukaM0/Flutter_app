import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/calculator_provider.dart';
import '../widgets/calculator_display.dart';
import '../widgets/button_grid.dart';
import '../../utils/theme/app_theme.dart';

class CalculatorPage extends ConsumerStatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends ConsumerState<CalculatorPage>
    with TickerProviderStateMixin {
  late AnimationController _displayFadeController;
  late AnimationController _gridSlideController;

  @override
  void initState() {
    super.initState();

    _displayFadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _gridSlideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Start animations after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLaunchAnimations();
    });
  }

  void _startLaunchAnimations() {
    _displayFadeController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _gridSlideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _displayFadeController.dispose();
    _gridSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/calculator_logo.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 12),
            const Text(
              'CalcPro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display panel with fade-in animation
            FadeTransition(
              opacity: _displayFadeController,
              child: const CalculatorDisplay(),
            ),
            // Button grid with slide-up animation
            Expanded(
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _gridSlideController,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: FadeTransition(
                  opacity: _gridSlideController,
                  child: const ButtonGrid(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
