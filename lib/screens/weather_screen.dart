import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/Theme_event.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/screens/city_search_screen.dart';
import 'package:weather_app/screens/settings_screen.dart';
import 'package:weather_app/screens/temperature_widget.dart';
import 'package:weather_app/states/theme_state.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Completer<void> _completer;
  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App using Flutter Bloc'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final typeCity = await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CitySearchScreen()));
              if (typeCity != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherEventRequested(typeCity));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context)
                  .add(ThemeEventWeatherChanged(weather: weatherState.weather));
            }
            _completer?.complete();
            _completer = Completer();
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: themeState.backgroundColor,
                        child: ListView(children: [
                          Column(
                            children: [
                              Text(
                                weather.location,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.textColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                              ),
                              Center(
                                child: Text(
                                  'Updated ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: themeState.textColor,
                                  ),
                                ),
                              ),
                              TemperatureWidget(weather: weather),
                            ],
                          ),
                        ]),
                      ),
                      onRefresh: () {
                        BlocProvider.of<WeatherBloc>(context)
                            .add(WeatherEventRefresh(city: weather.location));
                        return _completer.future;
                      });
                },
              );
            }
            if (weatherState is WeatherStateFailure) {
              return Text(
                "Something went wrong",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              );
            }
            return Center(
              child: Text(
                "select a location first !",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
