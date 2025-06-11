import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app_cubit/bloc/weather_cubit.dart';
import 'package:weather_app_cubit/bloc/weather_state.dart';
import 'package:weather_app_cubit/core/constants/app_const.dart';
import 'package:weather_app_cubit/core/constants/app_images.dart';
import 'package:weather_app_cubit/core/theme/app_text_style.dart';
import 'package:weather_app_cubit/core/weather_condition.dart';
import 'package:weather_app_cubit/core/widgets/container_frame.dart';
import 'package:weather_app_cubit/core/widgets/custom_text_form_field.dart';
import 'package:weather_app_cubit/core/widgets/row_time_degree.dart';

import '../bloc/internet_cubit.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/keyboard_dismiss.dart';
import '../model/forecast_weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool wasDisconnected = false;

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>();
    final internetCubit = context.read<InternetCubit>();
    return BlocConsumer<InternetCubit, InternetState>(
      listener: (BuildContext context, InternetState state) {
        if (state == InternetState.disconnected) {
          wasDisconnected = true;
        } else if (state == InternetState.connected && wasDisconnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppConstants.connectionRestored),
              backgroundColor: Colors.green,
            ),
          );
          wasDisconnected = false;
        }
      },
      builder: (context, internetState) {
        if (internetState == InternetState.disconnected) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 100, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    AppConstants.noInternetConnection,
                    style: AppTextStyle.f24Bo,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await internetCubit.checkConnection();
                    },
                    child: const Text(AppConstants.retry),
                  ),
                ],
              ),
            ),
          );
        }
        return KeyboardDismiss(
          child: Scaffold(
            backgroundColor: AppColors.borderSide,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: AppColors.fillCol,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              ),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: BlocConsumer<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is LoadingWeatherState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessWeatherState) {
                    final current = state.currentWeather;
                    final forecast = state.forecast;
                    return RefreshIndicator(
                      onRefresh: () async {
                        final cityName = current.cityName;

                        await internetCubit.checkConnection();
                        if (internetCubit.state == InternetState.disconnected) {
                          return;
                        }

                        weatherCubit.getWeatherByCity(cityName);
                      },
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 70),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                    image:
                                        WeatherCondition.getWeatherBackGround(
                                            current.weatherConditionCode),
                                  ),
                                  height: 350,
                                  width: double.infinity,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextFormField(
                                          formKey: formKey,
                                          onSubmitted: (value) async {
                                            FocusScope.of(context).unfocus();
                                            await internetCubit
                                                .checkConnection();
                                            weatherCubit
                                                .getWeatherByCity(value);
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 3),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                10,
                                              ),
                                            ),
                                            color: Colors.white30,
                                          ),
                                          child: Text(
                                            WeatherCondition.getGreetingMessage(
                                              current.dataFetchTime,
                                            ),
                                            style: AppTextStyle.f25Bo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 250,
                                  ),
                                  child: ContainerFrame(
                                    column: Column(
                                      children: [
                                        Text(
                                          "📍${current.cityName}",
                                          style: AppTextStyle.f24Bo,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          DateFormat('EEEE dd •')
                                              .add_jm()
                                              .format(current.dataFetchTime),
                                          style: AppTextStyle.f16W300,
                                        ),
                                        Divider(
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    current.weatherDescription
                                                        .toUpperCase(),
                                                    style: AppTextStyle.f20W500,
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Text(
                                                      "${current.temperature.toInt()}${AppConstants.celsius}",
                                                      style:
                                                          AppTextStyle.f35W600),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  WeatherCondition
                                                      .getWeatherIcon(
                                                    current
                                                        .weatherConditionCode,
                                                  ),
                                                  Text(
                                                      "${AppConstants.wind} ${current.windSpeed.toString()} ${AppConstants.speed}",
                                                      style:
                                                          AppTextStyle.f25W500),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ContainerFrame(
                              column: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RowTimeDegree(
                                        text: AppConstants.sunrise,
                                        image: AppImages.sunriseIcon,
                                        timeOrTemp: DateFormat()
                                            .add_jm()
                                            .format(current.sunrise),
                                      ),
                                      RowTimeDegree(
                                        text: AppConstants.sunset,
                                        image: AppImages.sunsetIcon,
                                        timeOrTemp: DateFormat()
                                            .add_jm()
                                            .format(current.sunset),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Divider(
                                      thickness: 0.3,
                                      color: AppColors.colorDivider,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RowTimeDegree(
                                        text: AppConstants.tempMax,
                                        color: Colors.red,
                                        image: AppImages.maxTempIcon,
                                        timeOrTemp:
                                            "${current.tempMax.toInt()}${AppConstants.celsius}",
                                      ),
                                      RowTimeDegree(
                                        text: AppConstants.tempMin,
                                        color: Colors.blue,
                                        image: AppImages.minTempIcon,
                                        timeOrTemp:
                                            "${current.tempMin.toInt()}${AppConstants.celsius}",
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ContainerFrame(
                              column: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(text: AppConstants.date),
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: AppConstants.temperatureType),
                                ),
                                title: ChartTitle(
                                    text: AppConstants
                                        .fiveDayTemperatureForecast),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                  orientation: LegendItemOrientation.horizontal,
                                ),
                                series: <CartesianSeries>[
                                  LineSeries<ForecastDataModel, String>(
                                    dataSource: forecast.forecastList,
                                    xValueMapper: (ForecastDataModel forecast,
                                            _) =>
                                        DateFormat('MMM - d')
                                            .format(forecast.dateTime),
                                    yValueMapper:
                                        (ForecastDataModel forecast, _) =>
                                            forecast.tempMax,
                                    name: AppConstants.tempMax,
                                    color: AppColors.tempMax,
                                  ),
                                  LineSeries<ForecastDataModel, String>(
                                    dataSource: forecast.forecastList,
                                    xValueMapper: (ForecastDataModel forecast,
                                            _) =>
                                        DateFormat('MMM - d')
                                            .format(forecast.dateTime),
                                    yValueMapper:
                                        (ForecastDataModel forecast, _) =>
                                            forecast.tempMin,
                                    name: AppConstants.tempMin,
                                    color: AppColors.tempMin,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await internetCubit.checkConnection();
                        if (internetCubit.state == InternetState.disconnected) {
                          return;
                        }

                        await weatherCubit.fetchWeatherData();
                      },
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 70,
                            right: 15,
                            left: 15,
                          ),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                formKey: formKey,
                                onSubmitted: (value) async {
                                  FocusScope.of(context).unfocus();
                                  await internetCubit.checkConnection();
                                  weatherCubit.getWeatherByCity(value);
                                },
                              ),
                              SizedBox(
                                height: 200,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                color: Colors.blueAccent,
                                onPressed: () async {
                                  await internetCubit.checkConnection();

                                  await weatherCubit.fetchWeatherData();
                                },
                                child: Text(
                                  AppConstants.retry,
                                  style: AppTextStyle.f20W500
                                      .copyWith(color: AppColors.borderSide),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              const Center(
                                child: Text(
                                  AppConstants.errorData,
                                  style: AppTextStyle.f24Bo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
                listener: (context, state) {
                  if (state is ErrorWeatherState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
