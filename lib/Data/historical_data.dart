class CountryHistoricalData {
  String country = '';
  String date = '';
  int cases = 0;
  int deaths = 0;
  int recovered = 0;
}

class HistoricalData {
  String date ;
  int cases ;
  int deaths ;
  int recovered ;

  HistoricalData({this.cases=0, this.date='', this.deaths=0, this.recovered=0});
}