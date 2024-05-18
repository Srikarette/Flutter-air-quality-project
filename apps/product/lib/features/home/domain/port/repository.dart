import 'package:product/features/home/data/models/weather.dart';
import 'package:product/features/home/data/models/weatherByCity.dart';

abstract class WeatherDataProjection {
  Future<AirQualityData> getCurrentLocationWeatherData();
  Future<AirQualityData> getCurrentLocationDataByLatLng(double lat, double lng);
  Future<AirQualityDataByCity> getWeatherDataByCity(String city);
  Future<AirQualityDataByCity> getLocationBySearch(String city);
}
