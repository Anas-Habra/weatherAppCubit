class CurrentWeatherModel {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weatherDescription;
  final String weatherIcon;
  final int weatherConditionCode;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime dataFetchTime;

  CurrentWeatherModel({
    required this.cityName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.weatherConditionCode,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.dataFetchTime,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List<dynamic>? ?? [];

    return CurrentWeatherModel(
      cityName: json['name'] ?? '',
      temperature: (json['main']?['temp'] ?? 0.0).toDouble(),
      tempMin: (json['main']?['temp_min'] ?? 0.0).toDouble(),
      tempMax: (json['main']?['temp_max'] ?? 0.0).toDouble(),
      weatherDescription:
          weatherList.isNotEmpty ? weatherList[0]['description'] ?? '' : '',
      weatherIcon: weatherList.isNotEmpty ? weatherList[0]['icon'] ?? '' : '',
      weatherConditionCode:
          weatherList.isNotEmpty ? weatherList[0]['id'] ?? 0 : 0,
      windSpeed: (json['wind']?['speed'] ?? 0.0).toDouble(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']?['sunrise'] ?? 0) * 1000,
          isUtc: true),
      sunset: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']?['sunset'] ?? 0) * 1000,
          isUtc: true),
      dataFetchTime: DateTime.now().toUtc(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'weatherConditionCode': weatherConditionCode,
      'windSpeed': windSpeed,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
      'dataFetchTime': dataFetchTime.toIso8601String(),
    };
  }
}
