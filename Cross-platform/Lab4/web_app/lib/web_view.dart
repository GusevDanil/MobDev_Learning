import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class WebView extends StatelessWidget {
  const WebView({Key? key}) : super(key: key);

  getViaHttp() async {
    final response =
        await http.get(Uri.parse("http://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      Logger().i(response.body);
    } else {
      throw Exception("Невзоможно получить посты");
    }
  }

  getViaDio() async {
    final response =
        await Dio().get("http://jsonplaceholder.typicode.com/users");
    if (response.statusCode == 200) {
      Logger().v(response.data);
    } else {
      throw Exception("Невзоможно получить посты");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  getViaHttp();
                },
                child: const Text("Network get via http")),
            ElevatedButton(
                onPressed: () {
                  getViaDio();
                },
                child: const Text("Network get via dio")),
          ],
        ),
      ),
    );
  }
}
