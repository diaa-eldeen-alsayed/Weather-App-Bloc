import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequested extends WeatherEvent {
  final String city;
  const WeatherEventRequested(this.city);
  @override
  List<Object> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String city;
  const WeatherEventRefresh({this.city});
  @override
  List<Object> get props => [city];
}
