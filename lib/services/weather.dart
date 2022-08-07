import 'location.dart';
import 'networking.dart';

// naš API key sa stranice open weather
const apiKey = 'a3f4c56f1d4bf4be98ac70508cd43d9e';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

// OPISI TRENUTNE VREMENSKE PROGNOZE
class WeatherModel {
  // metoda za dobivanje vremenske prognoze za određenu lokaciju putem text fielda
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper netWorkHelper = NetworkHelper(url);

    var weatherData = await netWorkHelper.getData();
    return weatherData;
  }

  // ovo je metoda kojom dobivamo informacije o vremenskoj prognozi na našoj trenutnoj lokaciji - označavamo kao future dynamic jer je funkcija asyn i nezz kad će se dogoditi a dynamic je jer su podatci iz API-a različiti
  Future<dynamic> getLocationWeather() async {
    // location objekt
    Location location = Location();
    await location.getCurrentLocation();

    // povlačenje podatak iz API-a
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    print(location.latitude);
    print(location.longitude);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  // na temelju conditiona iz API-a umećemo odgovarajuću ikonu
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

  // na temelju temperature koju dobijemo iz API-a vraćamo odgovarajuću poruku
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
