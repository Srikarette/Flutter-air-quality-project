import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/theme/theme_provider.dart';
import 'package:core_ui/widgets/composes/navbar/app-bar.dart';
import 'package:core_ui/widgets/elements/input/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:product/features/home/data/models/favorite.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  return dateFormat.format(dateTime);
}

String formatDateDay(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat dateFormat = DateFormat('EEEE');
  return dateFormat.format(dateTime);
}

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  late WeatherProjectionService _weatherService;
  late WeatherProjectionService _weatherSearchService;
  WeatherToDisplay? _currentWeather;
  WeatherToDisplayByCity? _currentSearchWeather;

  final dayCounter = 365;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weatherService = getIt.get<WeatherProjectionService>();
    _weatherSearchService = getIt.get<WeatherProjectionService>();
    _fetchCurrentWeather();
  }

  Future<void> _fetchCurrentWeather() async {
    try {
      final weatherData = await _weatherService.getCurrentLocationWeather();
      setState(() {
        _currentWeather = weatherData;
      });
      if (_currentWeather?.cityName != null) {
        _fetchSearchWeather(_currentWeather!.cityName);
      } else {
        _fetchSearchWeather('');
      }
    } catch (error) {
      setState(() {});
      _fetchSearchWeather('');
    }
  }

  Future<void> _fetchSearchWeather(String city) async {
    try {
      final weatherData =
          await _weatherSearchService.getWeatherDataByCity(city);
      final filteredData = WeatherToDisplayByCity(
        weatherDataList: weatherData.weatherDataList?.where((data) {
              final dateTime = DateTime.parse(data.time?.stime ?? '');
              final now = DateTime.now();
              final isWithinPastYear =
                  dateTime.isAfter(now.subtract(Duration(days: dayCounter)));
              final hasAqiData = data.aqi != "-";
              return isWithinPastYear && hasAqiData;
            }).toList() ??
            [],
      );
      setState(() {
        _currentSearchWeather = filteredData;
      });
    } catch (error) {
      setState(() {});
    }
  }

  Future<void> _searchWeatherByCity(String city) async {
    setState(() {});
    await _fetchSearchWeather(city);
  }

  void addToFavorites(num? uid, String? name, String? country, String? aqi,
      String? stime) async {
    var box = Hive.box<Favorite>('favorites');
    var favorite = Favorite(
        uid: uid, name: name, country: country, aqi: aqi, stime: stime);
    await box.put(uid, favorite);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final color = ref.watch(appThemeProvider).themeColor;

        return Scaffold(
            backgroundColor: color.backgroundPrimary,
            appBar: AppBar(
              title: const Text('Add Location'),
              backgroundColor: const Color.fromRGBO(29, 196, 250, 1),
            ),
            body: Column(children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSearchInput(
                            placeHolder: 'Search city',
                            controller: _searchController,
                            onSubmitted: _searchWeatherByCity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_currentSearchWeather?.weatherDataList != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _currentSearchWeather!.weatherDataList!
                          .map((weatherData) {
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                addToFavorites(
                                    weatherData.uid,
                                    weatherData.station!.name,
                                    weatherData.station!.country,
                                    weatherData.aqi,
                                    weatherData.time!.stime);
                              },
                              child: CardSearchStatus(
                                dailyAvg: weatherData.aqi ?? 'Unknown',
                                city: weatherData.station?.name ?? 'Unknown',
                                updateTime:
                                    weatherData.time?.stime ?? 'Unknown',
                              ),
                            ),
                            const Positioned(
                              top: 10,
                              right: 10,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 24.0,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
            ]));
      },
    );
  }
}
