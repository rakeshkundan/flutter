// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  // Location({this.latitude, this.longitude});
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        throw Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;

      // LocationPermission check = await Geolocator.checkPermission();
      // if (check)
      //   LocationPermission permission = await Geolocator.requestPermission();
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);
      // if (permission == LocationPermission.whileInUse ||
      //     permission == LocationPermission.always) {
      //   latitude = position.latitude;
      //   longitude = position.longitude;
      // } else if (permission == LocationPermission.deniedForever) {
      //   Future.error(
      //       'Location permissions are permanently denied, we cannot request permissions.');
      // } else {
      //   permission = await Geolocator.requestPermission();
      // }
    } catch (e) {
      longitude = 0.0;
      latitude = 0.0;
      print(e);
    }
  }
}
