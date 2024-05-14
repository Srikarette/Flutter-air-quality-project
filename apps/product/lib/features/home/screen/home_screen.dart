import 'package:flutter/material.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:core_libs/dependency_injection/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherProjectionService _weatherService;
  WeatherToDisplay? _currentWeather;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _weatherService = getIt.get<WeatherProjectionService>();
    _fetchCurrentWeather();
  }

  Future<void> _fetchCurrentWeather() async {
    try {
      final weatherData = await _weatherService.getCurrentLocationWeather();
      setState(() {
        _currentWeather = weatherData as WeatherToDisplay?;
        _isLoading = false;
        _hasError = false;
      });
    } catch (error) {
      print('Error fetching weather data: $error');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _hasError
            ? Text('Failed to fetch weather data')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'City: ${_currentWeather?.cityName ?? 'Unknown'}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              'Update Time: ${_currentWeather?.updateTime ?? 'Unknown'}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'PM2.5 Forecast:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _currentWeather?.pm25Forecast.length ?? 0,
                itemBuilder: (context, index) {
                  final dailyForecast = _currentWeather!.pm25Forecast[index];
                  return ListTile(
                    title: Text('Date: ${dailyForecast.day}'),
                    subtitle: Text('Avg: ${dailyForecast.avg}, Max: ${dailyForecast.max}, Min: ${dailyForecast.min}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
