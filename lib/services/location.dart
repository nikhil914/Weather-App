import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      print(e);
    }
  }
}
//var id = jsonDecode(data)['weather'][0]['id'];
//var temp = jsonDecode(data)['main']['temp'];
//var name = jsonDecode(data)['name'];
