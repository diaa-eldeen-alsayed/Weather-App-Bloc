import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final Weather weather;

  const ThemeEventWeatherChanged({@required this.weather})
      : assert(weather != null);

  @override
  List<Object> get props => [weather];
}
