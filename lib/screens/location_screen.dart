import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_assignment/screens/city_screen.dart';
import 'package:weather_app_assignment/services/weather.dart';
import 'package:weather_app_assignment/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic> locationWeather;
  const LocationScreen({super.key, required this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late int temperature;
  late int humidity;
  late double wind;
  late int clouds;
  late String? weatherIcon;
  late String cityName;
  late String weatherMessage;
  late String? typedName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['icon'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherData['name'];
      typedName = cityName;
      humidity = weatherData['main']['humidity'];
      wind = weatherData['wind']['speed'];
      clouds = weatherData['clouds']['all'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.black26],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      },
                      child: const Icon(
                        Icons.replay_outlined,
                        size: 50.0,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weatherModel.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: const Icon(
                        Icons.search_outlined,
                        size: 50.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    '$temperature°',
                    style: kTempTextStyle,
                  ),
                ),
                Center(
                  child: Text(
                    cityName,
                    style: kMessageTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Lottie.asset('assets/$weatherIcon.json'),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.white24,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                              child: Lottie.asset('assets/clouds.json',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              '$clouds %',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.white24,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                              child: Lottie.asset('assets/humidity.json',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              '$humidity %',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.white24,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                              child: Lottie.asset('assets/wind.json',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              '$wind m/s',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
