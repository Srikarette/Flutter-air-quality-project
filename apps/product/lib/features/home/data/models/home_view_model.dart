import 'package:product/features/home/data/models/home_state.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:product/features/home/domain/services/location_service.dart';
import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  WeatherProjectionService _weatherService = getIt<WeatherProjectionService>();
  WeatherProjectionService _weatherSearchService = getIt<WeatherProjectionService>();

  @override
  HomeState build() => HomeState(
      loading: false,
      hasError: false,
      currentPosition: null,
      currentWeather: null,
      currentSearchWeather: null
  );


  Future<void> fetchCurrentWeather() async {
    try {
      state = state.copyWith(loading: true, hasError: false);
      final weatherData = await _weatherService.getCurrentLocationWeather();
      state = state.copyWith(currentWeather: weatherData, loading: false);
      await fetchSearchWeather(weatherData.cityName ?? '');
    } catch (error) {
      state = state.copyWith(hasError: true, loading: false);
      await fetchSearchWeather('');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final locationService = LocationService();
      final position = await locationService.getCurrentLocation();
      state = state.copyWith(currentPosition: position);
    } catch (error) {
      // Handle location error
    }
  }

  Future<void> fetchSearchWeather(String city) async {
    try {
      final weatherData = await _weatherSearchService.getWeatherDataByCity(city);
      final filteredData = WeatherToDisplayByCity(
        weatherDataList: weatherData.weatherDataList?.where((data) {
          final dateTime = DateTime.parse(data.time?.stime ?? '');
          final now = DateTime.now();
          return dateTime.isAfter(now.subtract(Duration(days: 365))) && data.aqi != "-";
        }).toList() ?? [],
      );
      state = state.copyWith(currentSearchWeather: filteredData, loading: false, hasError: false);
    } catch (error) {
      state = state.copyWith(hasError: true, loading: false);
    }
  }

  Future<void> searchWeatherByCity(String city) async {
    state = state.copyWith(loading: true, hasError: false);
    await fetchSearchWeather(city);
  }
}