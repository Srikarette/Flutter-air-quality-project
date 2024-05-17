import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/theme/theme_provider.dart';
import 'package:core_ui/widgets/elements/botton/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:core_ui/widgets/composes/navbar/app-bar.dart';
import 'package:product/features/home/presentation/widgets/component/card_status.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';
import 'package:product/features/home/screen/add_location_screen.dart';
import 'package:product/features/home/screen/favotire_list_screen.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherProjectionService _weatherService;
  late WeatherProjectionService _weatherSearchService;
  WeatherToDisplay? _currentWeather;
  WeatherToDisplayByCity? _currentSearchWeather;

  final dayCounter = 365;
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  bool _hasError = false;

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
        _isLoading = false;
        _hasError = false;
      });
      if (_currentWeather?.cityName != null) {
        _fetchSearchWeather(_currentWeather!.cityName);
      } else {
        _fetchSearchWeather('');
      }
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      _fetchSearchWeather('');
    }
  }

  Future<void> _fetchSearchWeather(String city) async {
    try {
      final weatherData = await _weatherSearchService.getWeatherDataByCity(city);
      final filteredData = WeatherToDisplayByCity(
        weatherDataList: weatherData.weatherDataList?.where((data) {
          final dateTime = DateTime.parse(data.time?.stime ?? '');
          final now = DateTime.now();
          final isWithinPastYear = dateTime.isAfter(now.subtract(Duration(days: dayCounter)));
          final hasAqiData = data.aqi != "-";
          return isWithinPastYear && hasAqiData;
        }).toList() ?? [],
      );
      setState(() {
        _currentSearchWeather = filteredData;
        _isLoading = false;
        _hasError = false;
      });
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _searchWeatherByCity(String city) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    await _fetchSearchWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final color = ref.watch(appThemeProvider).themeColor;
        final dailyForecast = _currentWeather?.pm25Forecast[2];
        final tomorrowForecast = _currentWeather?.pm25Forecast[3];
        final dayAfterTomorrowForecast = _currentWeather?.pm25Forecast[4];

        String updateTime = 'Unknown';
        if (_currentWeather?.updateTime != null) {
          updateTime = formatDateTime(_currentWeather!.updateTime);
        }

        String tomorrowDay = 'Unknown';
        if (tomorrowForecast != null && tomorrowForecast.day != null) {
          tomorrowDay = formatDateDay(tomorrowForecast.day!);
        }

        String dayAfterTomorrowDay = 'Unknown';
        if (dayAfterTomorrowForecast != null && dayAfterTomorrowForecast.day != null) {
          dayAfterTomorrowDay = formatDateDay(dayAfterTomorrowForecast.day!);
        }

        return MaterialApp(
          home: Scaffold(
            backgroundColor: color.backgroundPrimary,
            appBar: CustomAppBar(
              searchController: _searchController,
              onSearchSubmitted: _searchWeatherByCity,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  if (dailyForecast != null && tomorrowForecast != null && dayAfterTomorrowForecast != null)
                    CardStatus(
                      dailyAvg: dailyForecast.avg ?? 0,
                      tomorrowAvg: tomorrowForecast.avg ?? 0,
                      dayAfterTomorrowAvg: dayAfterTomorrowForecast.avg ?? 0,
                      city: _currentWeather?.cityName ?? 'Unknown',
                      updateTime: updateTime,
                      tomorrowDay: tomorrowDay,
                      dayAfterTomorrowDay: dayAfterTomorrowDay,
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        title: 'ADD LOCATION',
                        titleColor: Colors.grey,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  AddLocationScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      PrimaryButton(
                        title: 'MANAGE',
                        titleColor: Colors.grey,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  FavoriteList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_currentSearchWeather?.weatherDataList != null)
                    Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: _currentSearchWeather!.weatherDataList!.map((weatherData) {
                                    return CardSearchStatus(
                                      dailyAvg: weatherData.aqi ?? 'Unknown',
                                      city: weatherData.station?.name ?? 'Unknown',
                                      updateTime: weatherData.time?.stime ?? 'Unknown',
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_downward, color: Colors.grey),
                            const Text(
                              'Scroll down for more',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}