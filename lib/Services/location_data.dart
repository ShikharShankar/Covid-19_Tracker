import 'package:location/location.dart' hide LocationAccuracy ;
import 'package:geocoding/geocoding.dart' as geo;

class MyLocationData{
  double latitude=0.0;
  double longitude=0.0;
  String country="India";

  Future<void> getLocationData() async{
    try{
      Location location = new Location() ;

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled=await location.serviceEnabled();
      if(!_serviceEnabled){
        _serviceEnabled=await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();

      latitude = _locationData.latitude!;
      longitude = _locationData.longitude!;

      List<geo.Placemark> placeMark = await geo.placemarkFromCoordinates(latitude, longitude);

      country = placeMark[0].country!;

      country == 'United States' ? country = 'USA' : country = country;
      country == 'United Kingdom' ? country = 'UK' : country = country;
      country == 'India' ? country = 'IND' : country = country;
      country == 'Bangladesh' ? country = 'BGD' : country = country;
      country == 'Brazil' ? country = 'BRA' : country = country;
      country == 'Canada' ? country = 'CAN' : country = country;
      country == 'China' ? country = 'CHN' : country = country;
      country == 'France' ? country = 'FRA' : country = country;
      country == 'Germany' ? country = 'DEU' : country = country;
      country == 'Italy' ? country = 'ITA' : country = country;
      country == 'Nepal' ? country = 'NPL' : country = country;
      country == 'Pakistan' ? country = 'PAK' : country = country;
      country == 'Singapore' ? country = 'SGP' : country = country;

      print(country);


    }
    catch(error)
    {
      print(error);
    }
  }
}
