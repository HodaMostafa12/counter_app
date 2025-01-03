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

  void _reset() {
    setState(() {
      counter.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter APP",style: TextStyle(color: Colors.brown,fontSize: 30,fontWeight: FontWeight.bold),),
            Text(counter.count.toString(),
              style: TextStyle(
                  color: Colors.brown,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _decrement, child: const Text("decrement")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _reset, child: const Text("reset")),
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
