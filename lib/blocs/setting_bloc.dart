import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/settings_event.dart';
import 'package:weather_app/states/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(temperatureUnit: TemperatureUnit.celsius));

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsEventToggleUnit) {
      yield SettingsState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius);
    }
  }
}
