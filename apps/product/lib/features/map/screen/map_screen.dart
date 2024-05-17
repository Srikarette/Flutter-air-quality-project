import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/widgets/elements/input/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import '../../home/domain/entities/weatherToDisplay.dart';
import '../../home/domain/entities/weatherToDisplayByCity.dart';
import '../../home/domain/port/service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat dateFormat = DateFormat('HH:mm');
  return dateFormat.format(dateTime);
}

class _MapScreenState extends State<MapScreen> {
  late WeatherProjectionService _weatherService;
  late WeatherProjectionService _weatherSearchService;
  List<Marker> markers = [];
  WeatherToDisplay? _currentWeather;
  WeatherToDisplayByCity? _currentSearchWeather;
  final _pmValue = ['No filter','0-50', '51-100', '101-200', '<200'];
  String _dropDownMenu = 'No filter';

  final dayCounter = 365;

  @override
  void initState() {
    super.initState();
    _weatherService = getIt.get<WeatherProjectionService>();
    _weatherSearchService = getIt.get<WeatherProjectionService>();
    _fetchCurrentWeather();
    fetchMarkerFromCity('Chiang Mai');
  }

  Future<void> _fetchCurrentWeather() async {
    try {
      final weatherData = await _weatherService.getCurrentLocationWeather();
      setState(() {
        _currentWeather = weatherData;
      });
      if (_currentWeather?.cityGeo != null) {
        _currentWeather!.cityGeo;
      } else {
        _fetchSearchWeather('');
      }
    } catch (error) {
      setState(() {
        // Handle error
      });
      _fetchSearchWeather('');
    }
  }

  Future<void> _fetchSearchWeather(String city) async {
    try {
      final weatherData =
      await _weatherSearchService.getWeatherDataByCity(city);
      final filteredData = WeatherToDisplayByCity(
        weatherDataList: weatherData.weatherDataList
            ?.where((data) {
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
      setState(() {
        // Handle error
      });
    }
  }

  bool _isMarkerInRange(String pm25) {
    // Always return true when 'No filter' is selected
    if (_dropDownMenu == 'No filter') {
      return true;
    }
    // Check the range for other filter options
    int value = int.tryParse(pm25) ?? 0;
    if (_dropDownMenu == '0-50' && value >= 0 && value <= 50) {
      return true;
    } else if (_dropDownMenu == '51-100' && value >= 51 && value <= 100) {
      return true;
    } else if (_dropDownMenu == '101-200' && value >= 101 && value <= 200) {
      return true;
    } else if (_dropDownMenu == '<200' && value > 200) {
      return true;
    }
    return false;
  }

  Color getColorForPm25(String pm25) {
    int value = int.tryParse(pm25) ?? 0;
    // Return color based on PM2.5 value even when 'No filter' is selected
    if (_dropDownMenu == '0-50' && value >= 0 && value <= 50) {
      return Colors.green;
    } else if (_dropDownMenu == '51-100' && value >= 51 && value <= 100) {
      return Colors.amberAccent;
    } else if (_dropDownMenu == '101-200' && value >= 101 && value <= 200) {
      return Colors.red;
    } else if (_dropDownMenu == '<200' && value > 200) {
      return Colors.purpleAccent;
    }
    // For 'No filter', return colors based on the PM2.5 value
    if (value >= 0 && value <= 50) {
      return Colors.green;
    } else if (value >= 51 && value <= 100) {
      return Colors.amberAccent;
    } else if (value >= 101 && value <= 200) {
      return Colors.red;
    } else if (value > 200) {
      return Colors.purpleAccent;
    }
    return Colors.transparent; // Default color
  }



  Future<void> fetchMarkerFromCity(String city) async {
    try {
      final weatherData = await _weatherSearchService.getWeatherDataByCity(city);
      final filteredData = weatherData.weatherDataList?.where((data) {
        final dateTime = DateTime.parse(data.time?.stime ?? '');
        final now = DateTime.now();
        final isWithinPastYear = dateTime.isAfter(now.subtract(Duration(days: dayCounter)));
        final hasAqiData = data.aqi != "-";
        return isWithinPastYear && hasAqiData && _isMarkerInRange(data.aqi ?? '');
      }).toList() ?? [];

      markers.clear();
      for (var data in filteredData) {
        final List<double> geo = data.geo ?? [];
        final LatLng coordinates = LatLng(geo[0], geo[1]);
        final pm25 = data.aqi ?? '-';
        final stationName = data.station?.name ?? '';
        print('Adding marker with AQI: $pm25');
        markers.add(
          Marker(
            point: coordinates,
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(pm25),
                      content: Text(stationName),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorForPm25(pm25),
                ),
                alignment: Alignment.center,
                child: Text(
                  pm25,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      setState(() {
        fetchMarkerFromCity(city);
      });
    } catch (error) {
      print("Error fetching markers: $error");
    }
  }

  void _handleCitySearch(String city) {
    _fetchCurrentWeather();
    fetchMarkerFromCity(city);
  }

  @override
  Widget build(BuildContext context) {
    String updateTime = 'Unknown';
    if (_currentWeather?.updateTime != null) {
      updateTime = formatDateTime(_currentWeather!.updateTime);
    }

    return Scaffold(
      body: _currentWeather == null
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Stack(
        children: [
          CustomSearchInput(
            placeHolder: 'Search',
            controller: TextEditingController(),
            onSubmitted: _handleCitySearch, width: 300,
          ),
          FlutterMap(
            options: MapOptions(
              initialCenter: _currentWeather!.cityGeo,
              initialZoom: 5,
            ),
            children: [
              TileLayer(
                urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
          Positioned(
            top: 0,
            left: 50,
            right: 0,
            child: SafeArea(
              child: CustomSearchInput(
                  controller: null, onSubmitted: (String word) => {}, width: 300,),
            ),
          ),
          Positioned(
            top: 60.0,
            right: 35.0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  "Data at $updateTime",
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60.0,
            left: 35.0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: DropdownButton<String>(
                  items: _pmValue.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropDownMenu = newValue!;
                    });
                  },
                  value: _dropDownMenu,
                  underline: Container(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
