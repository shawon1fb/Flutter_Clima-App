import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:clima/services/networking.dart';

const apiKey = '29d5f362ba3d9cc8855c516d0dde8fd3';
const openWeatherUrl = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  var latitude;
  var longitude;

  Future<dynamic> getCityWeather(String CityName) async{
    var url = '$openWeatherUrl?q=$CityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = new NetworkHelper(url: url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    print(position);
    latitude = position.latitude;
    longitude = position.longitude;
    NetworkHelper networkHelper = new NetworkHelper(
        url:
            '$openWeatherUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

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
    if (temp > 35) {
      return 'It\'s 🍦 time';
    } else if (temp > 25) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
