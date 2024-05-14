import 'package:product/features/home/domain/entities/weatherToDisplay.dart';

abstract class WeatherProjectionService {
  Future<WeatherToDisplay> getCurrentLocationWeather();
  Future<List<WeatherToDisplay>> getByCity(String city);
}
