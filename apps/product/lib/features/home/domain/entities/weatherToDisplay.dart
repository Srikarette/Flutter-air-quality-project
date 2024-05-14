

import 'package:product/features/home/data/models/weather.dart';

class WeatherToDisplay {
  String cityName;
  List<Pm25> pm25Forecast;
  String updateTime;

  WeatherToDisplay({
    required this.cityName,
    required this.pm25Forecast,
    required this.updateTime,
  });

  factory WeatherToDisplay.fromAirQualityData(AirQualityData airQualityData) {
    String cityName = airQualityData.data?.city?.name ?? "";
    String updateTime = airQualityData.data?.time?.iso ?? "";

    List<Pm25> pm25Forecast = [];
    if (airQualityData.data?.forecast?.daily?.pm25 != null) {
      pm25Forecast = airQualityData.data!.forecast!.daily!.pm25!;
    }

    return WeatherToDisplay(
      cityName: cityName,
      pm25Forecast: pm25Forecast,
      updateTime: updateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'pm25Forecast': pm25Forecast.map((pm25) => pm25.toJson()).toList(),
      'updateTime': updateTime,
    };
  }
}
