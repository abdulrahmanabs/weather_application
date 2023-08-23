import 'package:flutter/material.dart';
import 'package:weather_application/screens/city_screen.dart';
import 'package:weather_application/services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temp;
  String? cityName;
  String? weatherIcon;

  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    UpdateUI(widget.weatherData);
  }

  @override
  void UpdateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        cityName = "NO DATA ";
        temp = 0;
        weatherIcon = "NO DATA";
        return;
      }

      cityName = weatherData['name'];
      temp = weatherData['main']['temp'].toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      var weatherData = weatherModel.getLocationData();
                      UpdateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (typedCity != null) {
                        var weatherData =
                            await weatherModel.getCityData(typedCity);
                        UpdateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherModel.getMessage(temp!)} in $cityName",
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
