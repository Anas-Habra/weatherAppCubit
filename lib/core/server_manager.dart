import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_cubit/core/constants/app_const.dart';
import 'package:weather_app_cubit/model/current_weather_model.dart';

import '../model/forecast_weather_model.dart';

class ServerManager {
  Future<CurrentWeatherModel> getWeatherByCity(String cityName) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.baseURL}?q=$cityName&appid=${AppConstants.apiKey}&units=metric'));
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(data);
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      throw ('Unauthorized, Forbidden ${response.statusCode} ${data['message']}');
    } else if (response.statusCode == 500) {
      throw ('Internal Server Error ${data['message']}');
    } else {
      throw ('Some error happened, try again');
    }
  }

  Future<CurrentWeatherModel> getWeatherByLocation(
      {required double lat, required double lon}) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.baseURL}?lat=$lat&lon=$lon&appid=${AppConstants.apiKey}&units=metric'));
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(data);
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      throw ('Unauthorized, Forbidden ${response.statusCode} ${data['message']}');
    } else if (response.statusCode == 500) {
      throw ('Internal Server Error ${data['message']}');
    } else {
      throw ('Some error happened, try again');
    }
  }

  Future<ForecastWeatherModel> getWeatherFiveDay(
      {required double lat, required double lon}) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.baseURLFiveDay}?lat=$lat&lon=$lon&appid=${AppConstants.apiKey}&units=metric'));
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ForecastWeatherModel.fromJson(data);
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      throw ('Unauthorized, Forbidden ${response.statusCode} ${data['message']}');
    } else if (response.statusCode == 500) {
      throw ('Internal Server Error ${data['message']}');
    } else {
      throw ('Some error happened, try again');
    }
  }

  Future<ForecastWeatherModel> getWeatherFiveDayByCity(String cityName) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.baseURLFiveDay}?q=$cityName&appid=${AppConstants.apiKey}&units=metric'));
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ForecastWeatherModel.fromJson(data);
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      throw ('Unauthorized, Forbidden ${response.statusCode} ${data['message']}');
    } else if (response.statusCode == 500) {
      throw ('Internal Server Error ${data['message']}');
    } else {
      throw ('Some error happened, try again');
    }
  }
}
