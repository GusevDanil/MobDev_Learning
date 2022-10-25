import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView>
    with SingleTickerProviderStateMixin {
  TextEditingController tController = TextEditingController();
  double progress = 0.0;
  String inpText = "";
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: tController,
            ),
            LinearProgressIndicator(
              value: progress,
            ),
            Text(inpText.isEmpty
                ? "Здесь будет текст, который вы введете"
                : inpText),
            CheckboxListTile(
              title: const Text("Вы уверены?"),
              value: flag,
              onChanged: (flag) {
                changeToggleValue();
              },
            ),
            ElevatedButton(
                onPressed: () {
                  setProgress();
                },
                child: const Text("Progress"))
          ],
        ),
      ),
    );
  }

  void changeToggleValue() {
    setState(() {
      flag = !flag;
    });
  }

  void setProgress() {
    setState(() {
      if (tController.text.isNotEmpty && flag) {
        if (progress >= 1.0) {
          inpText = tController.text;
          progress = 0.0;
        }
        progress += 0.1;
      }
    });
  }
}
