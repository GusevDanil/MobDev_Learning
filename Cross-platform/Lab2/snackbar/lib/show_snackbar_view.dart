import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class _SnackbarView extends State<SnackbarView>{

  bool isExpanded = false;
  _SnackbarView(this.isExpanded);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text("SnackBar App"),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () { showSnackbar(context); },
                child: const Text("OK"),
              ),
              TextField(
                controller: tfController,
              ),
              ElevatedButton(
                  onPressed: () { printDefaultLog(); },
                  child: const Text("Обычное логирование")
              ),
              ElevatedButton(
                  onPressed: () { printLoggerLog(); },
                  child: const Text("Логирование Logger")
              ),
              Text(
                   "Гусев Данил Евгеньевич",
                style: !isExpanded ? const TextStyle(fontSize: 14, color: Colors.red) :
                const TextStyle(fontSize: 25, color: Colors.green)
              ),
              ElevatedButton(
                  onPressed: () { changeExpandedState(); },
                  child: Text(!isExpanded ? "Увеличить" :
                  "Уменьшить")
              )
            ]
        )
      )
    );
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Кнопка ОК нажата"),
        )
    );
  }

  final tfController = TextEditingController();
  @override
  void dispose() {
    tfController.dispose();
    super.dispose();
  }

  void printDefaultLog() { debugPrint(tfController.text); }
  void printLoggerLog() { Logger().v(tfController.text); }
  void changeExpandedState() { setState(() { isExpanded = !isExpanded; }); }
}

class SnackbarView extends StatefulWidget {
  final bool isExpanded = false;
  const SnackbarView({super.key});
  @override
  _SnackbarView createState() => _SnackbarView(isExpanded);
}