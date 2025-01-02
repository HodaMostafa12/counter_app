
import 'package:counter_app/CounterApp/counter.dart';
import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  final Counter counter = Counter();

  void _increment() {
    setState(() {
      counter.increment();
    });
  }

  void _decrement() {
    setState(() {
      counter.decrement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("this count number"),
            Text(counter.count.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
