import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_libs/network/http_services.dart';
import '../../domain/port/repository.dart';
import '../models/weather.dart';

class WeatherRepository implements WeatherDataProjection {
  final HttpService httpService = getIt.get<HttpService>();

  static const String token = '2190be2f9c41f96905ba4fc092a664c0ad2d87b4';

  @override
  Future<AirQualityData> getCurrentLocationWeatherData() async {
    final response = await httpService.get('/feed/here/?token=$token');
    return AirQualityData.fromJson(response);
  }

  @override
  Future<List<AirQualityData>> getWeatherDataByCity(String city) async {
    final response = await httpService.get('/search/?token=$token&keyword=$city');
    List<AirQualityData> weatherData = [];
    for (dynamic res in response['data']) { // Assuming the response has a 'data' key
      weatherData.add(AirQualityData.fromJson(res));
    }
    return weatherData;
  }
}
