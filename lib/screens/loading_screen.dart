import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocation();
    getData();
  }

  void getlocation() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    print(loc.latitude);
    print(loc.longitude);
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    if (response.statusCode == 200) {
      String data = response.body;

      var id = jsonDecode(data)['weather'][0]['id'];
      var temp = jsonDecode(data)['main']['temp'];
      var name = jsonDecode(data)['name'];
      print(id);
      print(temp);
      print(name);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
