import 'package:weather_app_cubit/model/current_weather_model.dart';

import '../model/forecast_weather_model.dart';

abstract class WeatherState {}

class InitialWeatherState extends WeatherState {}

class LoadingWeatherState extends WeatherState {}

class SuccessWeatherState extends WeatherState {
  final CurrentWeatherModel currentWeather;
  final ForecastWeatherModel forecast;

  SuccessWeatherState({
    required this.currentWeather,
    required this.forecast,
  });
}

class ErrorWeatherState extends WeatherState {
  final String errorMessage;

  ErrorWeatherState(this.errorMessage);
}
