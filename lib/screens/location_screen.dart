import 'package:clima_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, required this.locationWeather})
      : super(key: key);

  final dynamic locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  // TEMPERATURA
  late double temperature;
  late int temp;
  // IKONA VREMENA
  late String weatherIcon;
  late String weatherMessage;
  late String cityName;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  //METODA ZA POKAZIVANJE LOKACIJE - obavezno SETSTATE
  // da nam se promjene vide u realnom vremenu moramo ubaciti sve u set state
  dynamic updateUI(dynamic weatherData) {
    setState(() {
      // provjera da li su nam podatci null kako bismo vratili poruku useru da imamo problem,
      // možemo napraviti pop up notifikaciju za obavijest
      if (weatherData == null) {
        temp = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        // sa return odradimo sve iznad navedeno i onda izađemo iz funkcije
        return;
      }
      temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
      // CONDITION JE LOKALNA VARIJABLA KOJU UBACIMO U KREIRANU FUNKCIJU UNUTAR WEATHER FILE-A DA DOBIJEMO IKONU KOJA ODGOVARA VREMENSKOJ PROGNOZI
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      // NAZIV LOKACIJE
      cityName = weatherData['name'];
      // OPIS PROGNOZE
      weatherMessage = weather.getMessage(temp);
      print(temperature);
      print(condition);
      print(cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: const AssetImage('images/location_background.jpg'),
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LOCATION ICON - KLIKNOM NA OVAJ BUTTON REFRESHA NAM SE LOKACIJA I DOBIJEMO NOVE PODATKE
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  // CITY ICON - ODVODI NAS NA CITY EKRAN - async je jer vraća future, odnosno ne znamo kada će user imati input u text field
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      print(typedName);
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(Icons.location_city,
                        size: 50.0, color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    // TEMPERATURA
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    // IKONA
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              // OPIS VREMENSKE PROGNOZE
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
