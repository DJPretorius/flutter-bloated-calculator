
import 'package:calculator/albums/album_list.dart';
import 'package:calculator/calculator/calculator_state.dart';
import 'package:calculator/calculator/history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'calculator/calculator.dart';
import 'echo/echo_page.dart';

void main() {
  runApp(const CalculatorWidget());
}

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({Key? key}) : super(key: key);

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {

  int currentDestination = 3;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorState>(
      create: (context) => CalculatorState(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: currentDestination,
            onDestinationSelected: (int index) => {
              setState(() {
                currentDestination = index;
              })
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.calculate),
                label: 'Calculator',
              ),
              NavigationDestination(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              NavigationDestination(
                icon: Icon(Icons.photo_album),
                label: 'Album',
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Echo',
              ),
            ],
          ),
          body: <Widget>[
            Calculator(),
            HistoryList(),
            AlbumList(),
            EchoPage()
          ][currentDestination],
        ),
      ),
    );
  }
}












