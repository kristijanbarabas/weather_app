import 'package:flutter/material.dart';
import 'package:clima_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_app/services/weather.dart';

// sample API
/* const apiSample =
    'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22'; */

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
// dohvaćanje lokacije - kreiramo metodu getLocation()
// dodajemo modifier async a tijelo metode ubacimo await što znači da čekamo da se izvrši await dio prije nego što program napravi išta drugo, u ovom slučaju da isprinta position
// initState metoda je stateful widget metoda koja se pokrene prilikom kreiranja widgeta, ona se pokrene prije build metode, a staful widget još ima destroy metodu s kojom se on uništi
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // kreiramo novi weather model kak bismo mogli koristiti weatherData i onda ga spremimo u varijablu koju ubacimo u navigatora
    WeatherModel weatherModel = WeatherModel();
    // moramo označiti kao await jer vraća Future!!!
    var weatherData = await weatherModel.getLocationWeather();
    // ili u jednoj liniji
    /* var weatherData = WeatherModel().getLocationWeather(); */

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
    //To query the current location of the device simply make a call to the getCurrentPosition method. You can finetune the results by specifying the following parameters: desiredAccuracy, timeLimit...
    // ERROR HANDLING
    /*  try {
      // TEST //somethingThatExpectsLesThan10(12);
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);
    } catch (e) {
      print(e);
    } */
  }
// TEST // throw an exception ako je n veći od 10
/*   void somethingThatExpectsLesThan10(int n) {
    if (n > 10) {
      throw 'n is greater than 10, n should be always less than 10';
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );

    // try and catch
    /* try dio kaže da kreiramo container ako uspijemo iz stringa dobiti double, ali ako ne uspijemo dobiti double onda uhvatimo error i vratimo container koji ima default vrijednost */
// 1. NAČIN
    /* String myMargin = 'ABC';
    try {
      double myMarginAsADouble = double.parse(myMargin);

      return Scaffold(
        body: Container(
          color: Colors.red,
          margin: EdgeInsets.all(myMarginAsADouble),
        ),
      );
    } catch (e) {
      print(e);
      return Scaffold(
        body: Container(
          color: Colors.red,
          margin: EdgeInsets.all(30.0),
        ),
      );
    } */
// 2. NAČIN
// ako myMaringAsAdouble ne uspijemo parsat onda u catch ubacimo default vrijednost i returnamo scaffold kao dio build metode
    /*  String myMargin = 'ABC';
    // ako stavim DATA TYPE double onda baca error jer double ne može biti null pa onda samo deklariram varijablu sa var
    var myMarginAsADouble;
    try {
      myMarginAsADouble = double.parse(myMargin);
    } catch (e) {
      print(e);
      // myMarginAsADouble = 30.0;
    }

    return Scaffold(
      body: Container(
          // 3. NAČIN - NULL AWARE OPERATOR
          margin: EdgeInsets.all(myMarginAsADouble ?? 30.0),
          color: Colors.red),
    ); */
  }
}

/*  double temperature = decodedData['main']['temp'];
    print(temperature);
    int condition = decodedData['weather'][0]['id'];
    print(condition);
    String cityName = decodedData['name'];
    print(cityName); */