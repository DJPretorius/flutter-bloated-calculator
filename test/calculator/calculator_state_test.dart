import 'package:calculator/calculator/calculator.dart';
import 'package:calculator/calculator/calculator_button.dart';
import 'package:calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Calculator", () {
    testWidgets("Calculator button has symbol", (widgetTester) async {
      const widget = CalculatorWidget();
      await widgetTester.pumpWidget(widget);

      final button = find.text("1");
      expect(button, findsOneWidget);

      await widgetTester.tap(find.text("Echo"));
      await widgetTester.pump();

      final appBar = find.text("Echo Webserver");
      expect(appBar, findsOneWidget);
    });
  });
}