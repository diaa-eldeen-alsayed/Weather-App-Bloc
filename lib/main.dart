import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'blocs/weather_bloc_observer.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsBloc()),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: MyApp(
        weatherRepository: weatherRepository,
      )));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final WeatherRepository weatherRepository;
  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App with Bloc',
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherScreen(),
      ),
    );
  }
}
