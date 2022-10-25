import 'package:flutter/material.dart';

enum Switcher { first, second, third }

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int showedDigit = 1;
  Switcher switcher = Switcher.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: 80,
                child: Row(children: [
                  Expanded(
                      child: Text(
                          switcher == Switcher.first
                              ? showedDigit.toString()
                              : "",
                          textAlign: TextAlign.center)),
                  Expanded(
                      child: Text(
                          switcher == Switcher.second
                              ? showedDigit.toString()
                              : "",
                          textAlign: TextAlign.center)),
                  Expanded(
                      child: Text(
                          switcher == Switcher.third
                              ? showedDigit.toString()
                              : "",
                          textAlign: TextAlign.center))
                ])),
            SizedBox(
                height: 80,
                child: Column(
                  children: [
                    Expanded(
                        child: Text(
                            switcher == Switcher.first
                                ? showedDigit.toString()
                                : "",
                            textAlign: TextAlign.center)),
                    Expanded(
                        child: Text(
                            switcher == Switcher.second
                                ? showedDigit.toString()
                                : "",
                            textAlign: TextAlign.center)),
                    Expanded(
                        child: Text(
                            switcher == Switcher.third
                                ? showedDigit.toString()
                                : "",
                            textAlign: TextAlign.center)),
                  ],
                )),
            Expanded(
                child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  switcher == Switcher.first ? showedDigit.toString() : "",
                  textAlign: TextAlign.center,
                ),
                Text(switcher == Switcher.second ? showedDigit.toString() : "",
                    textAlign: TextAlign.center),
              ]),
              Text(switcher == Switcher.third ? showedDigit.toString() : "",
                  textAlign: TextAlign.center)
            ])),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    rollTextWidgets();
                  },
                  child: const Text("Roll"),
                ))
          ],
        ),
      ),
    );
  }

  void rollTextWidgets() {
    setState(() {
      showedDigit += 1;
      switch (switcher) {
        case Switcher.first:
          switcher = Switcher.second;
          break;
        case Switcher.second:
          switcher = Switcher.third;
          break;
        case Switcher.third:
          switcher = Switcher.first;
          break;
      }
    });
  }
}
