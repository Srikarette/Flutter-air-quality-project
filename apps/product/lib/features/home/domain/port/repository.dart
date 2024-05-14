import 'package:product/features/home/data/models/weather.dart';
import 'package:product/features/home/data/models/weatherByCity.dart';

abstract class WeatherDataProjection {
  Future<AirQualityData> getCurrentLocationWeatherData();
  Future<AirQualityDataByCity> getWeatherDataByCity(String city);
}
