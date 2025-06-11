import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cubit/bloc/weather_state.dart';
import 'package:weather_app_cubit/core/location_manager.dart';
import 'package:weather_app_cubit/core/server_manager.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(InitialWeatherState()) {
    fetchWeatherData();
  }

  final ServerManager serverManager = ServerManager();
  final LocationManager locationManager = LocationManager();

  Future<void> fetchWeatherData() async {
    emit(LoadingWeatherState());
    try {
      await locationManager.getLocation();

      final current = await serverManager.getWeatherByLocation(
        lon: locationManager.longitude!,
        lat: locationManager.latitude!,
      );

      final forecast = await serverManager.getWeatherFiveDay(
        lon: locationManager.longitude!,
        lat: locationManager.latitude!,
      );

      emit(SuccessWeatherState(
        currentWeather: current,
        forecast: forecast,
      ));
    } catch (e) {
      emit(ErrorWeatherState(e.toString()));
    }
  }

  Future<void> getWeatherByCity(String cityName) async {
    emit(LoadingWeatherState());
    try {
      final current = await serverManager.getWeatherByCity(cityName);
      final forecast = await serverManager.getWeatherFiveDayByCity(cityName);

      emit(SuccessWeatherState(
        currentWeather: current,
        forecast: forecast,
      ));
    } catch (e) {
      emit(ErrorWeatherState(e.toString()));
    }
  }
}
