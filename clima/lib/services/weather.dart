import 'package:clima/services/networking.dart';
import '../services/location.dart';

class WeatherModel {
  Future getCityWeather(String city) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=3b0af900ac460cd00baac8b3fdb7c283';
    NetworkHelper nethelp = NetworkHelper(url: url);
    var weatherData = await nethelp.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=3b0af900ac460cd00baac8b3fdb7c283&units=metric';
    NetworkHelper nethelp = NetworkHelper(url: url);
    var weatherData = await nethelp.getData();
    return weatherData;
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
