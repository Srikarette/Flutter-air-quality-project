import 'package:flutter/material.dart';
import 'package:product/features/home/domain/entities/weatherToDisplayByCity.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:core_libs/dependency_injection/get_it.dart';

class KeyWordLocationTestScreen extends StatefulWidget {
  const KeyWordLocationTestScreen({Key? key}) : super(key: key);

  @override
  State<KeyWordLocationTestScreen> createState() => _KeyWordLocationTestScreenState();
}

class _KeyWordLocationTestScreenState extends State<KeyWordLocationTestScreen> {
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
      final weatherData = await _weatherService.getWeatherDataByCity('chiangmai');
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

  Future<void> _searchWeatherByCity(String city) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final weatherData = await _weatherService.getWeatherDataByCity(city);
      setState(() {
        _currentWeather = weatherData;
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
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search City',
            border: InputBorder.none,
            icon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
          onSubmitted: (value) {
            _searchWeatherByCity(value);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _hasError
            ? Text('Failed to fetch weather data')
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  'City: ${_currentWeather?.cityName ?? 'Unknown'}',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 10),
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
