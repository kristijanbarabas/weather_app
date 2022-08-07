// paket nazovemo http kako bismo mogli drugačije pristuputi njegovim metodama
import 'package:http/http.dart' as http;
// paket za pretvaranje JSON-a
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<dynamic> getData() async {
    // get metoda iz http paketa
    // JSON formatted API response
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // json iz responsea smo spremili u varijablu data
      String data = response.body;
      //print(data);
      /*  // json convert - source je varijabla data kojoj onda dajemo KEY iz JSON-a ['coord'] pa drugi key  ['lon'] da dođemo do vrijednosti longituda
      var longitude = jsonDecode(data)['coord']['lon'];
      print(longitude);
      // ponavljamo korake prema key-u, a za index ubacimo broj
      var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      print(weatherDescription); */
      // dekodiranje dohvaćenih podataka iz JSON-a koji su spremljeni u varijablu data - ostavimo data type dynamic jer ne znamo koji je type dok se ne dekodira
      return jsonDecode(data);
      // pa onda umjesto da svaki put pišemo jsonDecode(data) ubacimo samo novu varijablu decodedData
      // možemo provjeriti što nam je koji data type da nije sve samo var odnosno dynamic

    } else {
      print(response.statusCode);
    }
    // potrebni podatci se nalaze u Body propertyu Response klase/objekta
    //print(response.body);
    // status kod što se dogodilo kada smo napravili http request
    // print(response.statusCode);
  }
}
