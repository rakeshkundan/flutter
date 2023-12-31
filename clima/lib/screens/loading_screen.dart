// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:clima/screens/location_screen.dart';

import 'package:flutter/material.dart';

import '../services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    try {
      WeatherModel weatherModel = WeatherModel();
      var weatherData = await weatherModel.getLocationWeather();
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return LocationScreen(
            weatherData: weatherData,
          );
        }),
      );
      // SystemNavigator.pop();
    } catch (e) {
      print('exception');
    }
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getLocationData();

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),

      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       getLocation();
      //       //Get the current location
      //     },
      //     child: Text('Get Location'),
      //   ),
      // ),
    );
  }
}
