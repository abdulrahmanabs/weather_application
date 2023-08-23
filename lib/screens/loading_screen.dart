import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_application/screens/location_screen.dart';
import 'package:weather_application/services/networking.dart';
import 'package:weather_application/services/weather.dart';
import '../services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getLocationData();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  weatherData: weatherData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitThreeInOut(
        color: Colors.white,
        size: 150.0,
      )),
    );
  }
}
  /*double temprature = decodedData['main']['temp'];
    int condition = decodedData['weather'][0]['id'];
    String cityName = decodedData*/