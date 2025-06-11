import 'package:flutter/material.dart';
import 'package:weather_app_cubit/core/constants/app_images.dart';

class WeatherCondition {
  static getWeatherBackGround(int code) {
    switch (code) {
      case >= 200 && < 300:
        return DecorationImage(
          image: AssetImage(
            AppImages.lightningBack,
          ),
          fit: BoxFit.cover,
        );
      case >= 300 && < 400:
        return DecorationImage(
          image: AssetImage(
            AppImages.rainBack,
          ),
          fit: BoxFit.cover,
        );
      case >= 500 && < 600:
        return DecorationImage(
          image: AssetImage(
            AppImages.rainBack,
          ),
          fit: BoxFit.cover,
        );
      case >= 600 && < 700:
        return DecorationImage(
          image: AssetImage(
            AppImages.snowBack,
          ),
          fit: BoxFit.cover,
        );
      case >= 700 && < 800:
        return DecorationImage(
          image: AssetImage(
            AppImages.snowBack,
          ),
          fit: BoxFit.cover,
        );
      case == 800:
        return DecorationImage(
          image: AssetImage(
            AppImages.sunBack,
          ),
          fit: BoxFit.cover,
        );
      case > 800 && <= 804:
        return DecorationImage(
          image: AssetImage(
            AppImages.cloudBack,
          ),
          fit: BoxFit.cover,
        );
      default:
        return DecorationImage(
          image: AssetImage(
            AppImages.cloudBack,
          ),
          fit: BoxFit.cover,
        );
    }
  }

  static Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          AppImages.lightningState,
          height: 150,
          width: 150,
        );
      case >= 300 && < 400:
        return Image.asset(
          AppImages.drizzlingState,
          height: 150,
          width: 150,
        );
      case >= 500 && < 600:
        return Image.asset(
          AppImages.rainState,
          height: 150,
          width: 150,
        );
      case >= 600 && < 700:
        return Image.asset(
          AppImages.snowState,
          height: 150,
          width: 150,
        );
      case >= 700 && < 800:
        return Image.asset(
          AppImages.windsState,
          height: 150,
          width: 150,
        );
      case == 800:
        return Image.asset(
          AppImages.sunState,
          height: 150,
          width: 150,
        );
      case > 800 && <= 804:
        return Image.asset(
          AppImages.partlyCloudyState,
          height: 150,
          width: 150,
        );
      default:
        return Image.asset(
          AppImages.partlyCloudyState,
          height: 150,
          width: 150,
        );
    }
  }

  static String getGreetingMessage(DateTime currentTime) {
    final hour = currentTime.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning ☀️';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon 🌤️';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening 🌙';
    } else {
      return 'Good Night 🌌';
    }
  }
}
