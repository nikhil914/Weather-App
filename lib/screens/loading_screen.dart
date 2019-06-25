import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Apikey = '44465be905ef7d408988716706c152fe';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

double langt;
double longt;

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocationData();
  }

  void getlocationData() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    langt = loc.latitude;
    longt = loc.longitude;
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$langt&lon=$longt&appid=$Apikey&units=metric');

    var weatherData = await networkhelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationweather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
