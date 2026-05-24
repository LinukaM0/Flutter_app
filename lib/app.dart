import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/calculator/calculator_page.dart';
import 'theme/app_theme.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: AppTheme.darkTheme,
      home: const CalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
