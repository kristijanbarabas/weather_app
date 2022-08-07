import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/city_background.jpg'),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
            child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              // BACK BUTTON
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              // TEXT FIELD
              child: TextField(
                // property s kojim dohvaćamo vrijednosti (naziv grada);
                // value je ono što upišemo u text field koji pamti svaku promjenu, a s obzirom da upisujemo ime grada odmah ćemo upisani tekst spremiti u varijablu cityName
                onChanged: (value) {
                  cityName = value;
                  print(value);
                },
                style: TextStyle(color: Colors.black),
                decoration: kTextFieldInputDecoration,
              ),
            ),
            TextButton(
              onPressed: () {
                // passing data backwards
                Navigator.pop(context, cityName);
              },
              child: const Text(
                'Get Weather',
                style: kButtonTextStyle,
              ),
            )
          ],
        )),
      ),
    );
  }
}
