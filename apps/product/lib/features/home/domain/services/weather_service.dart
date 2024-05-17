import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';
import 'package:product/features/home/domain/port/repository.dart';
import 'package:product/features/home/domain/port/service.dart';

class WeatherService extends WeatherProjectionService {
  final WeatherDataProjection repository = getIt.get<WeatherDataProjection>();

  @override
  Future<WeatherToDisplay> getCurrentLocationWeather() async {
    final rawWeather = await repository.getCurrentLocationWeatherData();
    return WeatherToDisplay.fromAirQualityData(rawWeather);
  }

  @override
  Future<WeatherToDisplayByCity> getWeatherDataByCity(String city) async {
    final rawWeather = await repository.getWeatherDataByCity(city);
    return WeatherToDisplayByCity.fromWeatherByCity(rawWeather);
  }

  @override
  Future<WeatherToDisplayByCity> getLocationBySearch(String city) async{
    final rawWeather = await repository.getWeatherDataByCity(city);
    return WeatherToDisplayByCity.fromSearchLocation(rawWeather);
  }
}
