class CountryVirusData {
  String country;
  String flagUrl;
  int confirmedCases;
  int deaths;
  int recovered ;
  int active ;

  CountryVirusData(
      {this.confirmedCases=0,
        this.country='',
        this.deaths=0,
        this.flagUrl='',
        this.recovered=0,
        this.active=0});
}