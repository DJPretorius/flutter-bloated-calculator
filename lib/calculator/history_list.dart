import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_state.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History List"),
      ),
      body: Container(
        child: Consumer<CalculatorState>(
          builder: (context, state, child) {
            return ListView(
              children: state.getHistory().map((e) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e),
                ),
              )).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("+"),
      ),
    );
  }
}