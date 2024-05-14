import 'package:flutter/material.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:core_libs/dependency_injection/get_it.dart';

class CurrentLocationApiTestScreen extends StatefulWidget {
  const CurrentLocationApiTestScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationApiTestScreen> createState() => _CurrentLocationApiTestScreenState();
}

class _CurrentLocationApiTestScreenState extends State<CurrentLocationApiTestScreen> {
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
        _currentWeather = weatherData;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.blue, // Set your preferred color
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _hasError
            ? Text(
          'Failed to fetch weather data',
          style: TextStyle(color: Colors.red), // Set your preferred error text color
        )
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _currentWeather?.pm25Forecast.length ?? 0,
                itemBuilder: (context, index) {
                  final dailyForecast = _currentWeather!.pm25Forecast[index];
                  return Card(
                    elevation: 4, // Set your preferred elevation
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Set your preferred margin
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${dailyForecast.day}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Avg: ${dailyForecast.avg}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Max: ${dailyForecast.max}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Min: ${dailyForecast.min}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
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
