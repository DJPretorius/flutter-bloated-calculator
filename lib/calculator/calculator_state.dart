import 'package:flutter/cupertino.dart';

class CalculatorState extends ChangeNotifier {
  final List<String> _equationHistory = [];
  final List<String> _symbols = [];

  var result = 0;

  void addOperator(String operator) {
    _symbols.add(operator);
    notifyListeners();
  }

  String printEquation() {
    var equation = "";
    var symbols = [..._symbols];
    while (symbols.isNotEmpty) {
      var operatorIndex = symbols.indexWhere((element) => int.tryParse(element) == null);
      if (operatorIndex == 0) {
        return equation += " ${symbols[operatorIndex]}";
      }
      if (operatorIndex == -1) {
        var newNumber = symbols.reduce((value, element) => value + element);
        equation += " $newNumber";
        return equation;
      }

      var operator = symbols[operatorIndex];
      var leftOperand = symbols.getRange(0, operatorIndex).reduce((value, element) => value + element);
      if (equation.isEmpty) {
        equation = "$leftOperand $operator";
      } else {
        equation += "$leftOperand $operator";
      }
      symbols.removeRange(0, operatorIndex + 1);
    }

    return equation;
  }

  void calculate() {
    var result = 0;

    var symbols = [..._symbols];
    while (symbols.isNotEmpty) {
      print(symbols);
      var operatorIndex = symbols.indexWhere((element) => int.tryParse(element) == null);
      if (operatorIndex == 0 && result == 0) {
        print("OperatorIndex = 0");
        return;
      }
      if (operatorIndex == -1) {
        print("OperatorIndex = -1");
        var newNumber = symbols.reduce((value, element) => value + element);
        result += int.parse(newNumber);
        return;
      }

      var operator = symbols[operatorIndex];
      var leftOperand = result;
      if (result == 0) {
        leftOperand = int.parse(symbols.getRange(0, operatorIndex).reduce((value, element) => value + element));
      }
      print("result = $result, leftOperand = $leftOperand");
      symbols.removeRange(0, operatorIndex + 1);

      var nextOperatorIndex = symbols.indexWhere((element) => int.tryParse(element) == null);
      var rightOperand = 0;

      if (nextOperatorIndex == -1) {
        rightOperand = int.parse(symbols.reduce((value, element) => value + element));
        symbols.clear();
      } else {
        rightOperand = int.parse(symbols.getRange(0, nextOperatorIndex).reduce((value, element) => value + element));
        symbols.removeRange(0, nextOperatorIndex);
      }

      print("result = $result, leftOperand = $leftOperand, rightOperand = $rightOperand");
      switch (operator) {
        case "+": result = leftOperand + rightOperand;
        break;
        case "-": result = leftOperand - rightOperand;
        break;
      }
    }

    this.result = result;
    notifyListeners();
  }

  void clearCurrentEquation() {
    _symbols.clear();
    result = 0;
    notifyListeners();
  }

  void saveEquation() {
    var equation = printEquation();

    calculate();

    var result = "$equation = ${this.result}";

    _equationHistory.add(result);
  }

  List<String> getHistory() => _equationHistory;
}