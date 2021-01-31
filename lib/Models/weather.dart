import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int id;
  final String weatherStateName;
  final String weatherStateAbbr;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  const Weather(
      {this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location});
  @override
  List<Object> get props => [
        id,
        weatherStateName,
        weatherStateAbbr,
        minTemp,
        maxTemp,
        theTemp,
        locationId,
        created,
        lastUpdated,
        location
      ];

  // "consolidated_weather":[
  //   {
  //     "id":5417235775488000,
  //    "weather_state_name":"Heavy Cloud",
  //    "weather_state_abbr":"hc",
  //    "wind_direction_compass":"NE",
  //      "created":"2021-01-08T21:20:01.755227Z",
  //      "applicable_date":"2021-01-08",
  //      "min_temp":-1.09,
  //     "max_temp":2.84,
  //      "the_temp":2.16,
  //      "wind_speed":2.185186036907129,
  //      "wind_direction":41.682951436699724,
  //      "air_pressure":1018.0,
  //      "humidity":85,
  //      "visibility":5.527407440547204,
  //      "predictability":71
  //   },]

  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject["consolidated_weather"][0];
    return Weather(
      id: consolidatedWeather["id"],
      weatherStateName: consolidatedWeather["weather_state_name"] ?? '',
      weatherStateAbbr: consolidatedWeather["weather_state_abbr"] ?? '',
      minTemp: consolidatedWeather["min_temp"] as double,
      maxTemp: consolidatedWeather["max_temp"] as double,
      theTemp: consolidatedWeather["the_temp"] as double,
      locationId: jsonObject["woeid"] as int,
      created: consolidatedWeather["created"],
      lastUpdated: DateTime.now(),
      location: jsonObject["title"],
    );
  }
}
