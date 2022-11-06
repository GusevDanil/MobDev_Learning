import 'dart:math';

import 'package:flutter/material.dart';

class ElementsListView extends StatelessWidget {
  const ElementsListView({Key? key}) : super(key: key);

  getRandomColor() {
    return Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Element(
              boxColor: getRandomColor(),
              text: "Sample text",
            ),
            Element(
              boxColor: getRandomColor(),
              text: "Здесь могла быть ваша реклама",
            ),
            Element(
              boxColor: getRandomColor(),
              text: "Продам гараж",
            ),
          ]
        )
      )
    );
  }
}

class Element extends StatelessWidget {
  final String? text;
  final Color? boxColor;
  const Element({Key? key, this.text, this.boxColor}) : super(key: key);

  onTapElement(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("It's $text"),
          duration: const Duration(seconds: 1),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: key,
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () { onTapElement(text!, context); },
          child: Row(
            children: [
              Container(
                color: boxColor,
                height: 50,
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(text!)
            ]
          )
        )
    );
  }
}
