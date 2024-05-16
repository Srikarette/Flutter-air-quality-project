import 'package:flutter/material.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/widgets/composes/navbar/app-bar.dart';

class CurrentLocationApiTestScreen extends StatefulWidget {
  const CurrentLocationApiTestScreen({super.key});

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
      appBar: CustomAppBar(),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _hasError
            ? const Text('Failed to fetch weather data')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'City: ${_currentWeather?.cityName ?? 'Unknown'}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              'Update Time: ${_currentWeather?.updateTime ?? 'Unknown'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'PM2.5 Forecast:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _currentWeather?.pm25Forecast.length ?? 0,
                itemBuilder: (context, index) {
                  final dailyForecast = _currentWeather!.pm25Forecast[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${dailyForecast.day}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Avg: ${dailyForecast.avg}', style: const TextStyle(fontSize: 14)),
                            Text('Max: ${dailyForecast.max}', style: const TextStyle(fontSize: 14)),
                            Text('Min: ${dailyForecast.min}', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
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
