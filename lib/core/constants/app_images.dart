class AppImages {
  static const String baseLottiePath = "assets/images/lottie_weather/";
  static const String baseBackGroundPath = "assets/images/background/";
  static const String baseStateWeatherPath = "assets/images/state_weather/";
  static const String baseIconWeatherPath = "assets/images/icon_weather/";

  static const String svgExtension = ".svg";
  static const String pngExtension = ".png";
  static const String lottieExtension = ".json";
  static const String jpgExtension = ".jpg";

  /// Lottie
  static const String weatherLottie =
      '${baseLottiePath}weather_lottie$lottieExtension';

  /// BACKGROUND
  static const String cloudBack =
      "${baseBackGroundPath}cloud$jpgExtension";
  static const String lightningBack =
      "${baseBackGroundPath}lightning$jpgExtension";
  static const String rainBack =
      "${baseBackGroundPath}rain$pngExtension";
  static const String snowBack =
      "${baseBackGroundPath}snow$jpgExtension";
  static const String sunBack =
      "${baseBackGroundPath}sun$jpgExtension";
  static const String windsBack =
      "${baseBackGroundPath}winds$jpgExtension";


  /// STATE WEATHER
  static const String cloudyState = '${baseStateWeatherPath}cloudy$pngExtension';
  static const String drizzlingState = '${baseStateWeatherPath}drizzling$pngExtension';
  static const String lightningState = '${baseStateWeatherPath}lightning$pngExtension';
  static const String partlyCloudyState = '${baseStateWeatherPath}partly_cloudy$pngExtension';
  static const String rainState = '${baseStateWeatherPath}rain$pngExtension';
  static const String snowState = '${baseStateWeatherPath}snow$pngExtension';
  static const String stormyState = '${baseStateWeatherPath}stormy$pngExtension';
  static const String sunState = '${baseStateWeatherPath}sun$pngExtension';
  static const String windsState = '${baseStateWeatherPath}winds$pngExtension';




  /// IconWeather
  static const String maxTempIcon =
      '${baseIconWeatherPath}max_temp$pngExtension';
  static const String minTempIcon =
      '${baseIconWeatherPath}min_temp$pngExtension';
  static const String sunriseIcon =
      '${baseIconWeatherPath}sunrise$pngExtension';
  static const String sunsetIcon =
      '${baseIconWeatherPath}sunset$pngExtension';
}
