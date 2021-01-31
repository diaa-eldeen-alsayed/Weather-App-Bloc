import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/Theme_event.dart';
import 'package:weather_app/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    ThemeState newThemeState;
    if (event is ThemeEventWeatherChanged) {
      if (event.weather.weatherStateAbbr == "c" ||
          event.weather.weatherStateAbbr == "lc") {
        newThemeState =
            ThemeState(backgroundColor: Colors.yellow, textColor: Colors.black);
      } else if (event.weather.weatherStateAbbr == "h" ||
          event.weather.weatherStateAbbr == "sn" ||
          event.weather.weatherStateAbbr == "sl") {
        newThemeState = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      } else if (event.weather.weatherStateAbbr == "hc") {
        newThemeState =
            ThemeState(backgroundColor: Colors.grey, textColor: Colors.black);
      } else if (event.weather.weatherStateAbbr == "hr" ||
          event.weather.weatherStateAbbr == "lr" ||
          event.weather.weatherStateAbbr == "s") {
        newThemeState =
            ThemeState(backgroundColor: Colors.indigo, textColor: Colors.white);
      } else if (event.weather.weatherStateAbbr == "t") {
        newThemeState = ThemeState(
            backgroundColor: Colors.deepPurple, textColor: Colors.black);
      } else {
        newThemeState = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      }
      yield newThemeState;
    }
  }
}
