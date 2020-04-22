class Weather{
  double lat;
  double lon;
  String condition;
  double temperature;
  double tempMin;
  double tempMax;
  double pressure;
  double humidity;
  double windSpeed;
  Weather(this.lat,this.lon,this.condition,this.temperature,this.tempMin,this.tempMax,this.pressure,this.humidity,this.windSpeed);
  getAll(){
    return [lat,lon,condition,temperature,tempMin,tempMax,pressure,humidity,windSpeed];
  }
  get getLatitude => lat;
  get getLongitude => lon;
  get getCondition => condition;
  get getTemperature => temperature;
  get getTempMin => tempMin;
  get getTempMax => tempMax;
  get getPressure => pressure;
  get getHumidity => humidity;
  get getWindSpeed => windSpeed;
}