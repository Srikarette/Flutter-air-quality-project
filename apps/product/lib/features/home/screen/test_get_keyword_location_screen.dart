import 'package:flutter/material.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:product/features/home/presentation/widgets/component/app-bar.dart';

class KeyWordLocationTestScreen extends StatefulWidget {
  const KeyWordLocationTestScreen({Key? key}) : super(key: key);

  @override
  State<KeyWordLocationTestScreen> createState() => _KeyWordLocationTestScreenState();
}

class _KeyWordLocationTestScreenState extends State<KeyWordLocationTestScreen> {

  final dayCounter = 365;
  late WeatherProjectionService _weatherService;
  WeatherToDisplayByCity? _currentWeather;
  bool _isLoading = true;
  bool _hasError = false;
  TextEditingController _searchController = TextEditingController();

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
    return Scaffold(
      appBar: CustomAppBar(
        searchController: _searchController,
        onSearchSubmitted: _searchWeatherByCity,
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _hasError
            ? Text('NO DATA FOUND')
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Display station data for each weather data
                if (_currentWeather?.weatherDataList != null)
                  ..._currentWeather!.weatherDataList!.map((weatherData) => Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Station Name: ${weatherData.station?.name ?? 'Unknown'}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'AQI: ${weatherData.aqi ?? 'Unknown'}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Time: ${weatherData.time?.stime ?? 'Unknown'}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Country: ${weatherData.station?.country ?? 'Unknown'}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
