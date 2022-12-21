import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_state.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({Key? key, required this.symbol}) : super(key: key);

  final String symbol;
  static const operators = ["+", "-"];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () {
          if(symbol == "=") {
            Provider.of<CalculatorState>(context, listen: false).calculate();
            Provider.of<CalculatorState>(context, listen: false).saveEquation();
          } else if(symbol == "C") {
            Provider.of<CalculatorState>(context, listen: false).clearCurrentEquation();
          } else {
            Provider.of<CalculatorState>(context, listen: false).addOperator(symbol);
          }
        },
        child: Text(symbol),
      ),
    );
  }
}