import 'package:flutter/material.dart';
import 'package:product/features/home/presentation/widgets/component/card_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card Status Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CardStatus(value: 25,value1: 75 ,value2: 150),
              CardStatus(value: 75,value1: 25 ,value2: 250),
              CardStatus(value: 150,value1: 75 ,value2: 25),
              CardStatus(value: 250,value1: 25 ,value2: 150),
            ],
          ),
        ),
      ),
    );
  }
}
