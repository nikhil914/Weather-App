import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocation();
  }

  void getlocation() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    print(loc.latitude);
    print(loc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
