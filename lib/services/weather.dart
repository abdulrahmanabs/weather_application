import 'package:weather_application/services/location.dart';

import 'networking.dart';

const String apiKey = "bd5e378503939ddaee76f12ad7a97608";
const String openWeatherUrl = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityData(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper("$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric");
    return await networkHelper.GetData();
  }

  Future<dynamic> getLocationData() async {
    Location location = Location();
    await location.GetLocation();

    NetworkHelper networkHelper = NetworkHelper(
        "$openWeatherUrl?lat=${location.latitude}&lon=${location.longtude}&appid=$apiKey&units=metric");
    return await networkHelper.GetData();
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
