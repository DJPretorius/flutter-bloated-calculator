
import 'package:calculator/calculator/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator/calculator.dart';

void main() {
  runApp(const CalculatorWidget());
}

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({Key? key}) : super(key: key);

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {

  double value = 0.0;
  String equation = "";


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorState>(
      create: (context) => CalculatorState(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Calculator()
      ),
    );
  }
}










