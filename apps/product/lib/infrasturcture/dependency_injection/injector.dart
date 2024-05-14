import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:product/features/home/data/repositories/weather_repository.dart';
import 'package:product/features/home/domain/port/repository.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:product/features/home/domain/services/weather_service.dart';

void registerProductServices() {
  getIt.registerSingleton<WeatherDataProjection>(WeatherRepository());
  getIt.registerSingleton<WeatherProjectionService>(WeatherService());
}