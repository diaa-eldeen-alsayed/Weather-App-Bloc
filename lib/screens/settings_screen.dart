import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/events/settings_event.dart';
import 'package:weather_app/states/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
            return ListTile(
              title: Text("Temperature Unit"),
              isThreeLine: true,
              subtitle: Text(
                  settingsState.temperatureUnit == TemperatureUnit.celsius
                      ? 'Celsuis'
                      : 'Fahrenheit'),
              trailing: Switch(
                  value:
                      settingsState.temperatureUnit == TemperatureUnit.celsius,
                  onChanged: (_) => BlocProvider.of<SettingsBloc>(context)
                      .add(SettingsEventToggleUnit())),
            );
          })
        ],
      ),
    );
  }
}
