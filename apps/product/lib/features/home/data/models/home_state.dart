import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required bool loading,
    required bool hasError,
    required Position? currentPosition,
    required WeatherToDisplay? currentWeather,
    required WeatherToDisplayByCity? currentSearchWeather,
  }) = _HomeState;
}
