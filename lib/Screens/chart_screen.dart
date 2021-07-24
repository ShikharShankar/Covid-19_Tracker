import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:covid_tracker/constants.dart';
import 'package:covid_tracker/Data/historical_data.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid_tracker/Services/api_data.dart';

class ChartsScreen extends StatefulWidget {
  final String countryName;
  final double cases;
  final double deaths;
  final double recovered;
  ChartsScreen({required this.countryName, required this.cases, required this.deaths, required this.recovered});

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {

  @override
  void initState() {
    getAndSetData();
    // TODO: implement initState
    super.initState();
  }

  ApiData apiData = ApiData();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<HistoricalData> countryData = [];
  List<charts.Series<HistoricalData, int>> _lineSeriesData = [];
  Map<String, double> _dataMap = Map();

  Map<String, dynamic> cases = Map();
  Map<String, dynamic> recovered = Map();
  Map<String, dynamic> deaths = Map();

  void getAndSetData() async{
    Map <String, dynamic> histData= widget.countryName == 'world' ? await apiData.getWorldHistoricalData() : await apiData.getCountryHistoricalData('${widget.countryName}');

    if(widget.countryName=='world')
    {
       cases=histData['cases'];
       deaths=histData['deaths'];
       recovered=histData['recovered'];

       for(var i=0;i<cases.length;i++)
       {
           final myData =HistoricalData(
             date: cases.keys.elementAt(i).toString(),
             cases: cases.values.elementAt(i),
             deaths: deaths.values.elementAt(i),
             recovered: recovered.values.elementAt(i),
           );

           countryData.add(myData);
       }
       return ;
    }

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('InfoGraphs'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.pie_chart),),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(xMargin(4)),
                  child: Text(
                      '${widget.countryName}',
                      style: TextStyle(
                        fontSize: yMargin(6),
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
                PieChart(
                  dataMap: _dataMap,
                  animationDuration: Duration(milliseconds: 500),
                  chartLegendSpacing: 30.0,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  initialAngleInDegree: 0,
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: true,
                    decimalPlaces: 1,
                    chartValueBackgroundColor: Colors.grey[200],
                  ),
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  colorList: [ Color(0xFFEF5350), Colors.blue, Color(0xFFFFCA28)],
                  chartType: ChartType.disc,
                ),
                Container(
                  width: double.infinity,
                  height: yMargin(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Cases: ${widget.cases.toStringAsFixed(0)}',
                        style: TextStyle(
                            fontSize: yMargin(3),
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Text(
                        'Recovered: ${widget.recovered.toStringAsFixed(0)}',
                        style: TextStyle(
                            fontSize: yMargin(3),
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Text(
                        'Deaths: ${widget.deaths.toStringAsFixed(0)}',
                        style: TextStyle(
                            fontSize: yMargin(3),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
    ),);
  }
}
