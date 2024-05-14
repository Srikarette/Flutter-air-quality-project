import 'package:product/features/home/data/models/weather.dart';

class WeatherToDisplay {
  String cityName;
  List<Daily> pm25Forecast;
  String updateTime;

  WeatherToDisplay({
    required this.cityName,
    required this.pm25Forecast,
    required this.updateTime,
  });

  factory WeatherToDisplay.fromAirQualityData(AirQualityData airQualityData) {
    return WeatherToDisplay(
      cityName: airQualityData.data.city.name,
      pm25Forecast: airQualityData.data.forecast.pm25,
      updateTime: airQualityData.data.time.iso,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'pm25Forecast': pm25Forecast.map((i) => i.toJson()).toList(),
      'updateTime': updateTime,
    };
  }
}
