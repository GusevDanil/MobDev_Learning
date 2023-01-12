import 'package:flutter/material.dart';
import 'package:weather_app/weather_model.dart';

class WeatherPage extends StatefulWidget {
  final WeatherModel weatherData;
  const WeatherPage({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<WeatherPage> createState() =>
      _WeatherPageState(weatherData: weatherData);
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherModel weatherData;
  _WeatherPageState({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${weatherData.name}, ${weatherData.sys!.country}",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Image(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${weatherData.weather![0].icon}@4x.png")),
          Text("${weatherData.weather![0].description}",
              style: const TextStyle(fontSize: 16)),
          Text("${weatherData.main!.temp!.round()}",
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(
              "${(weatherData.main!.pressure! * 0.750063755419211).toStringAsFixed(1)} мм рт. ст.",
              style: const TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
