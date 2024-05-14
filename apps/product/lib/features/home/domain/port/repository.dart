import 'package:product/features/home/data/models/weather.dart';

abstract class WeatherDataProjection {
  Future<AirQualityData> getCurrentLocationWeatherData();
  Future<List<AirQualityData>> getWeatherDataByCity(String city);
}
