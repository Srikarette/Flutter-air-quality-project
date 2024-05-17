import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_libs/network/dio_service.dart';
import 'package:core_libs/network/http_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product/features/home/data/mock/weatherMockData.dart';
import 'package:product/features/home/data/models/weather.dart';
import 'package:product/features/home/data/models/weatherByCity.dart';
import 'package:product/features/home/data/repositories/weather_repository.dart';

// Mock HttpService for testing WeatherRepository
class MockHttpService extends Mock implements HttpService {}

void main() {
  // Register core services before tests
  registerCoreServices();

  group('registerCoreServices Tests', () {

    test('registerSingleton should register DioService correctly', () {
      final httpService = getIt.get<HttpService>();
      expect(httpService, isA<DioService>());
    });
  });

  group('WeatherRepository Tests', () {
    late WeatherRepository weatherRepository;
    late MockHttpService mockHttpService;
    late MockCityData mockData;

    setUp(() {
      mockHttpService = MockHttpService();
      weatherRepository = WeatherRepository();
      mockData = MockCityData(); // Initialize mockData here
    });

    test('getCurrentLocationWeatherData returns AirQualityData', () async {
      // Mock response
      final mockResponse = mockData.data;

      // Call the method
      final result = await weatherRepository.getCurrentLocationWeatherData();

      // Check the result
      expect(result, isA<AirQualityData>());
      expect(result.toJson(), mockResponse);
    });

    test('getWeatherDataByCity returns AirQualityDataByCity', () async {
      // Mock response
      final mockResponse = mockData.cityData;

      // Call the method
      final result = await weatherRepository.getWeatherDataByCity('Chiang mai');

      // Check the result
      expect(result, isA<AirQualityDataByCity>());
      expect(result.toJson(), mockResponse);
    });
  });
}
