import 'package:covid_tracker/Screens/live_map_screen.dart';
import 'package:covid_tracker/Screens/prevention_screen.dart';
import 'package:covid_tracker/Services/api_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_tracker/Screens/home_screen.dart';
import 'package:covid_tracker/Screens/about_covid_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const routName = 'LoadingScreen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  ApiData apiData = ApiData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAndSetData();
    HomePage();
  }

  void getAndSetData() async {
    var data = await apiData.getVirusData();
    var locationData = await apiData.getLocationVirusData();
    var countriesData = await apiData.getCountriesVirusData();
    var statesData = await apiData.getStatesData();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(
          countriesData: countriesData,
          locationVirusData: locationData,
          virusData: data,
          statesData: statesData,
        ),
      ),
    );
  }

  final spinKit1 = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.red,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            "assets/icons/virus.svg",
            height: 200.0,
          ),
          Column(
            children: <Widget>[
              Text(
                "Covid Tracker",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'Fetching data, loading...\n', //  \n is used to provide space
                style: TextStyle(fontSize: 25.0),
              ),
              spinKit1,
            ],
          ),
        ],
      ),
    );
  }
}
