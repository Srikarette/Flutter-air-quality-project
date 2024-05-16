import 'package:core_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/widgets/composes/navbar/app-bar.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';

class KeyWordLocationTestScreen extends StatefulWidget {
  const KeyWordLocationTestScreen({super.key});

  @override
  State<KeyWordLocationTestScreen> createState() => _KeyWordLocationTestScreenState();
}

class _KeyWordLocationTestScreenState extends State<KeyWordLocationTestScreen> {

  final dayCounter = 365;
  late WeatherProjectionService _weatherService;
  WeatherToDisplayByCity? _currentWeather;
  bool _isLoading = true;
  bool _hasError = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weatherService = getIt.get<WeatherProjectionService>();
    _fetchCurrentWeather();
  }

  Future<void> _fetchCurrentWeather() async {
    try {
      final weatherData = await _weatherService.getWeatherDataByCity('');
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
        _currentWeather = filteredData;
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
    try {
      final weatherData = await _weatherService.getWeatherDataByCity(city);
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
        _currentWeather = filteredData;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
    final color = ref.watch(appThemeProvider).themeColor;
    return Scaffold(
       backgroundColor: color.backgroundPrimary,
      appBar: CustomAppBar(
        searchController: _searchController,
        onSearchSubmitted: _searchWeatherByCity,
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _hasError
                ? const Text(
                    'NO DATA FOUND',
                    style: TextStyle(
                      color: Colors.grey, 
                      fontSize: 18.0, 
                      fontWeight: FontWeight.bold, 
                    ),
                  )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Display station data for each weather data
                if (_currentWeather?.weatherDataList != null)
                  ..._currentWeather!.weatherDataList!.map((weatherData) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardSearchStatus(
                        dailyAvg: weatherData.aqi ?? 'Unknown',
                        city: weatherData.station?.name ?? 'Unknown',
                        updateTime: weatherData.time?.stime ?? 'Unknown',
                      ),
                    ],
                                      )),
              ],
            ),
          ),
        ),
      ),
    );
    },
    );
  }
}
