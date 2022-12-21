import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_button.dart';
import 'calculator_state.dart';
import 'history_list.dart';

class Calculator extends StatelessWidget {
  const Calculator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CalculatorState>(
            builder: (context, state, child) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.printEquation()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.result.toString()),
                    )
                  ]
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CalculatorButton(symbol: "1"),
              CalculatorButton(symbol: "2"),
              CalculatorButton(symbol: "3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CalculatorButton(symbol: "4"),
              CalculatorButton(symbol: "5"),
              CalculatorButton(symbol: "6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CalculatorButton(symbol: "7"),
              CalculatorButton(symbol: "8"),
              CalculatorButton(symbol: "9"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CalculatorButton(symbol: "+"),
              CalculatorButton(symbol: "-"),
              CalculatorButton(symbol: "="),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CalculatorButton(symbol: "C"),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.red[200],
    );
  }
}