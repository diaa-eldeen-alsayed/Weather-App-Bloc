import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherStateInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherEventRequested) {
      yield WeatherStateLoading();
      try {
        final weather = await weatherRepository.getWeatherFromCity(event.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (event is WeatherEventRefresh) {
      try {
        final weather = await weatherRepository.getWeatherFromCity(event.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
