import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    WeatherModel wb = WeatherModel();
    var weatherData = await wb.getlocationweather();
    var weatherForcast = await wb.getlocationForcast();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationweather: weatherData,
        locationForcast: weatherForcast,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Getting your Location',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: SpinKitHourGlass(
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
