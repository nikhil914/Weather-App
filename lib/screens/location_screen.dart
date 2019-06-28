import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather, this.locationForcast});
  final locationweather;
  final locationForcast;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  var temperature;
  var Cityname;
  var weatherIcon;
  String weatherText;
  int cmax, cmin, tmax, tmin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationweather, widget.locationForcast);
  }

  void updateUI(dynamic weatherData, dynamic weatherForcast) {
    setState(() {
      if (weatherData == null || weatherForcast == null) {
        temperature = 0;
        weatherIcon = "Error";
        weatherText = "Unable to get Weather data,Allow permission";
        Cityname = "";
        return;
      }

      double temp = double.parse(weatherData['main']['temp'].toString());
      temperature = temp.toInt();
      Cityname = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherText = weather.getMessage(temperature);

      //Today

      List clist = List();
      for (int i = 0; i < 7; i++) {
        double c1max =
            double.parse(weatherForcast['list'][i]['main']['temp'].toString());
        int cmaxl = c1max.toInt();
        clist.add(cmaxl);
      }
      clist.sort();
      cmax = clist[6]; //max
      cmin = clist[0]; //min

      //Tomorrow
      List tlist = List();
      for (int j = 7; j < 15; j++) {
        double t1max =
            double.parse(weatherForcast['list'][j]['main']['temp'].toString());
        int tmax1 = t1max.toInt();
        tlist.add(tmax1);
      }
      tlist.sort();
      tmax = tlist[7]; //max
      tmin = tlist[0]; //min
    });
  }

  @override
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
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weather.getlocationweather();
                      var weatherForcast = await weather.getlocationForcast();
                      updateUI(weatherdata, weatherForcast);
                      print('Clicked at updater current Location');
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (typedname != null) {
                        var weatherdata = await weather.cityweather(typedname);
                        var weatherForcast =
                            await weather.cityForcast(typedname);
                        updateUI(weatherdata, weatherForcast);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$weatherIcon️',
                        style: kConditionTextStyle,
                      ),
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    '$weatherText in $Cityname!',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
              Container(
                height: 10.0,
                width: double.infinity,
                color: Colors.black,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 110.0,
                    width: 10.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'आज ',
                          style: kdayTextStyle,
                        ),
                        Text(
                          'Max :$cmax°',
                          style: kmaxmintextstyle,
                        ),
                        Text(
                          'Min :$cmin°',
                          style: kmaxmintextstyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 110.0,
                    width: 10.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'कल ',
                          style: kdayTextStyle,
                        ),
                        Text(
                          'Max :$tmax°',
                          style: kmaxmintextstyle,
                        ),
                        Text(
                          'Min :$tmin°',
                          style: kmaxmintextstyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 110.0,
                    width: 10.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
