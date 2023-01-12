import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_page.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> with WidgetsBindingObserver {
  Future<WeatherModel> getWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=55.3333&lon=86.0833&appid=8e46f09547e6f433c2c475c28ebf7f0a&units=metric&lang=ru'));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Ошибка при запросе данных");
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      log(state.toString());
      build(context);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}",
                  style: const TextStyle(color: Colors.red));
            }
            if (snapshot.hasData) {
              WeatherModel weatherData = snapshot.data!;
              return WeatherPage(weatherData: weatherData);
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
