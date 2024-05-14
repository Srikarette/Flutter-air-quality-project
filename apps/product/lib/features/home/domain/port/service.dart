import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';

abstract class WeatherProjectionService {
  Future<WeatherToDisplay> getCurrentLocationWeather();
  Future<WeatherToDisplayByCity> getWeatherDataByCity(String city);
}
