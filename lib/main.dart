import 'dart:ffi';

import 'package:flutter/material.dart';

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
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Calculator"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ),
        backgroundColor: Colors.red[200],
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: Text("+"),
        ),
      )
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({Key? key, required this.symbol}) : super(key: key);

  final String symbol;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () {
          
        },
        child: Text(symbol),
      ),
    );
  }
}

