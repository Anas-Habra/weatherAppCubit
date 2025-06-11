class ForecastWeatherModel {
  final String cityName;
  final List<ForecastDataModel> forecastList;

  ForecastWeatherModel({
    required this.cityName,
    required this.forecastList,
  });

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    final cityData = json['city'] ?? {};
    final forecastListJson = json['list'] as List<dynamic>? ?? [];

    final forecastList = forecastListJson
        .map((forecastJson) => ForecastDataModel.fromJson(forecastJson))
        .toList();

    return ForecastWeatherModel(
      cityName: cityData['name'] ?? '',
      forecastList: forecastList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'forecastList': forecastList.map((e) => e.toJson()).toList(),
    };
  }
}

class ForecastDataModel {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weatherDescription;
  final String weatherIcon;
  final int weatherConditionCode;
  final double windSpeed;

  ForecastDataModel({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.weatherConditionCode,
    required this.windSpeed,
  });

  factory ForecastDataModel.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List<dynamic>? ?? [];

    return ForecastDataModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] ?? 0) * 1000,
          isUtc: true),
      temperature: (json['main']?['temp'] ?? 0.0).toDouble(),
      tempMin: (json['main']?['temp_min'] ?? 0.0).toDouble(),
      tempMax: (json['main']?['temp_max'] ?? 0.0).toDouble(),
      weatherDescription:
          weatherList.isNotEmpty ? (weatherList[0]['description'] ?? '') : '',
      weatherIcon: weatherList.isNotEmpty ? (weatherList[0]['icon'] ?? '') : '',
      weatherConditionCode:
          weatherList.isNotEmpty ? (weatherList[0]['id'] ?? 0) : 0,
      windSpeed: (json['wind']?['speed'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'temperature': temperature,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'weatherConditionCode': weatherConditionCode,
      'windSpeed': windSpeed,
    };
  }
}
