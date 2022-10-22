
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Информация обо мне"),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: Strings.myInfo,
              ),
              const Image(
                image: NetworkImage('https://clck.ru/32Sekx'),
                width: 300,
                height: 300,
              ),
              SizedBox(
                  width: double.infinity,
                  child: (
                      ElevatedButton(
                        onPressed: () {  },
                        child: const Text("OK"),
                      )
                  )
              )
            ]
        ),
      ),
    );
  }
}

class Strings {
  static const String myInfo = "Гусев Данил, ФИТ-194";
}