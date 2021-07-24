import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final virusData;
  final locationVirusData;
  final countriesData;
  final statesData;

  HomePage(
      {this.locationVirusData,
      this.virusData,
      this.countriesData,
      this.statesData});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Home'),
      ),
    );
  }
}
