
import 'package:flutter/material.dart';
import 'package:weather_app_assignment/services/location.dart';
import 'package:weather_app_assignment/services/networking.dart';

const apiKey = '6278942b743c02d99c971b29cde8e254';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String? cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather({required BuildContext context}) async {
    Location location = Location();
    await location.getCurrentLocation(context: context);

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String? getWeatherIcon(String condition) {
    if (condition == '01d') {
      return 'clear_sky';
    } else if (condition == '01n') {
      return 'clear_sky_night';
    } else if (condition == '02d' || condition == '02n') {
      return 'few_clouds_day';
      // } else if (condition =='02n') {
      //   return 'few_clouds_night';
    } else if (condition == '03d' ||
        condition == '03n' ||
        condition == '04d' ||
        condition == '04n') {
      return 'broken_clouds';
    } else if (condition == '09d' || condition == '10d') {
      return 'rain_day';
    } else if (condition == '09n' || condition == '10n') {
      return 'rain_night';
    } else if (condition == '11d' || condition == '11n') {
      return 'thunderstorm';
    } else if (condition == '13d' || condition == '13n') {
      return 'snow';
    } else if (condition == '50d' || condition == '50n') {
      return 'mist';
    } else {
      return 'loading';
    }
  }
}
