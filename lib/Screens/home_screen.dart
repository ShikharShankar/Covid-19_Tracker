import 'package:covid_tracker/Data/country_virus_data.dart';
import 'package:covid_tracker/Data/virus_data.dart';
import 'package:covid_tracker/Screens/live_map_screen.dart';
import 'package:covid_tracker/Screens/prevention_screen.dart';
import 'package:covid_tracker/Widgets/drawer.dart';
import 'package:covid_tracker/Widgets/info_card.dart';
import 'package:covid_tracker/Widgets/prevention_card.dart';
import 'package:covid_tracker/Widgets/widget_card.dart';
import 'package:covid_tracker/Widgets/world_card.dart';
import 'package:covid_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  VirusData data = VirusData(confirmedCases: 0, recovered: 0, deaths: 0);

  CountryVirusData locationData = CountryVirusData(
    country: 'none',
    confirmedCases: 0,
    recovered: 0,
    deaths: 0,
  );

  int index = 0;
  List<CountryVirusData> countriesData = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void updateUI(dynamic virusData) {
    setState(
      () {
        if (virusData == null) {
          data = VirusData(confirmedCases: 0, recovered: 0, deaths: 0);
          return;
        }

        data = VirusData(
            confirmedCases: virusData['cases'],
            recovered: virusData['recovered'],
            deaths: virusData['deaths'],
            active: virusData['active']);
      },
    );
  }

  void updateCountriesUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
        );
        print('null');
        return;
      }
      for (var eachData in virusData) {
        final countryData = CountryVirusData(
            country: eachData['country'],
            confirmedCases: eachData['cases'],
            recovered: eachData['recovered'],
            deaths: eachData['deaths'],
            flagUrl: eachData['countryInfo']['flag'],
            active: eachData['active']);
        countriesData.add(countryData);
      }
    });
  }

  void updateLocationUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
          active: 0,
        );
        return;
      }

      locationData = CountryVirusData(
          country: virusData['country'],
          confirmedCases: virusData['cases'],
          recovered: virusData['recovered'],
          deaths: virusData['deaths'],
          active: virusData['active']);
    });
  }
  @override
  void initState() {
    updateUI(widget.virusData);
    updateLocationUI(widget.locationVirusData);
    updateCountriesUI(widget.countriesData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        backgroundColor: Colors.blue.withOpacity(0.07),
        title: Text(
            "Covid Tracker",
            style: TextStyle(
              color: Colors.black,
              fontSize: yMargin(3.2),
              fontFamily: 'Titillium',
            ),
        ),
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      drawer: ClipPath(
        clipper: MyCustomClipper(),
        child: buildDrawer(context, widget),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: xMargin(2),
                right: xMargin(2),
                top: yMargin(0.2),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.07),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Wrap(
                spacing: xMargin(3),
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: yMargin(2),
                children: <Widget>[
                  InfoCard(
                    title: "Confirmed",
                    color: Colors.red,
                    effectedNum: locationData.confirmedCases,
                  ),
                  InfoCard(
                    title: "Deaths",
                    color: Colors.grey,
                    effectedNum: locationData.deaths,
                    spot: "death",
                  ),
                  InfoCard(
                    title: "Recovered",
                    color: Colors.green,
                    effectedNum: locationData.recovered,
                  ),
                  InfoCard(
                    title: "Active",
                    color: Colors.blue,
                    effectedNum: locationData.active,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: xMargin(4)),
                        child: TextButton(
                          onPressed: (){},
                          child: Row(
                            children: <Widget>[
                              Text("Infographs"),
                              SizedBox(
                                width: 3,
                              ),
                              SvgPicture.asset(
                                "assets/icons/increase.svg",
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: yMargin(1), right: xMargin(6)),
                        child: Text(
                          "Location: ${locationData.country}\nLast updated: ${DateTime.now().toString().substring(0, 10)}",
                          style: TextStyle(fontSize: yMargin(1.4)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            WorldCard(
              widget: widget,
              cases: data.confirmedCases,
              deaths: data.deaths,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: xMargin(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: WidgetCard(
                      srcAsset: "assets/icons/virus.svg",
                      title: "COVID-19",
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: WidgetCard(
                      srcAsset: "assets/icons/india.svg",
                      title: "Indian States",
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsScreen(),
                      ),
                    ),
                    child: WidgetCard(
                        srcAsset: "assets/icons/live-map.svg",
                        title: "Live Map"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
