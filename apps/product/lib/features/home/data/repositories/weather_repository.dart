import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_libs/network/http_services.dart';
import 'package:product/features/home/data/models/weatherByCity.dart';
import '../../domain/port/repository.dart';
import '../models/weather.dart';

class WeatherRepository implements WeatherDataProjection {
  final HttpService httpService = getIt.get<HttpService>();

  static const String token = '2190be2f9c41f96905ba4fc092a664c0ad2d87b4';

  @override
  Future<AirQualityData> getCurrentLocationWeatherData() async {
    final response = await httpService.get('/feed/here/?token=$token');
    if (response != null) {
      return AirQualityData.fromJson(response);
    } else {
      throw Exception('Failed to fetch weather data: response is null');
    }
  }

  @override
  Future<AirQualityDataByCity> getWeatherDataByCity(String city) async {
    final response = await httpService.get('/search/?token=$token&keyword=$city');
    return AirQualityDataByCity.fromJson(response);
  }
  @override
  Future<AirQualityDataByCity> getLocationBySearch(String city) async {
    final response = await httpService.get('/feed/$city/?token=$token');
    return AirQualityDataByCity.fromJson(response);
  }

  @override
  Future<AirQualityData> getCurrentLocationDataByLatLng(double lat, double lng) async{
    final response = await httpService.get('/feed/geo:$lat;$lng/?token=$token');
    if (response != null) {
      return AirQualityData.fromJson(response);
    } else {
      throw Exception('Failed to fetch weather data: response is null');
    }
  }
}
