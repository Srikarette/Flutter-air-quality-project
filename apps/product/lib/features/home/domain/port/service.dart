import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';

abstract class WeatherProjectionService {
  Future<WeatherToDisplay> getCurrentLocationWeather();
  Future<WeatherToDisplay> getCurrentLocationDataByLatLng(double lat, double lng);
  Future<WeatherToDisplayByCity> getWeatherDataByCity(String city);
  Future<WeatherToDisplayByCity> getLocationBySearch(String city);
}
