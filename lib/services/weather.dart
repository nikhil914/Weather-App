import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const Apikey = '44465be905ef7d408988716706c152fe';

class WeatherModel {
  Future<dynamic> cityweather(String cityname) async {
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$Apikey&units=metric');

    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  Future<dynamic> cityForcast(String cityname) async {
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=$Apikey&units=metric');

    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  Future<dynamic> getlocationweather() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$Apikey&units=metric');
    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  Future<dynamic> getlocationForcast() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${loc.latitude}&lon=${loc.longitude}&appid=$Apikey&units=metric');
    var ForcastData = await networkhelper.getData();
    return ForcastData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
