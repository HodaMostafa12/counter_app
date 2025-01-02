import 'package:counter_app/CounterApp/counter_ui.dart';
import 'package:counter_app/apiApp/veiw/User_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          HomePage(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
