import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Models/weather.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/states/settings_state.dart';
import 'package:weather_app/states/theme_state.dart';
import 'package:weather_icons/weather_icons.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  TemperatureWidget({Key key, this.weather})
      : assert(weather != null),
        super(key: key);
  int _toFahrenheit(double celsuis) => ((celsuis * 9 / 5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}F'
          : '${temp.round()}C';
  BoxedIcon _mapWeatherConditionToIcon({String weatherStateAbbr}) {
    switch (weatherStateAbbr) {
      case "c":
      case "lc":
        return BoxedIcon(WeatherIcons.day_sunny);
        break;
      case "h":
      case "sn":
      case "sl":
        return BoxedIcon(WeatherIcons.snow);
        break;
    }
    return BoxedIcon(WeatherIcons.sunset);
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mapWeatherConditionToIcon(
                weatherStateAbbr: weather.weatherStateAbbr),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, settingsState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Min temp: ${_formattedTemperature(weather.minTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: themeState.textColor),
                      ),
                      Text(
                        'Temp: ${_formattedTemperature(weather.theTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: themeState.textColor),
                      ),
                      Text(
                        'Max temp: ${_formattedTemperature(weather.maxTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                            fontSize: 18, color: themeState.textColor),
                      ),
                    ],
                  );
                })),
          ],
        ),
      ],
    );
  }
}
