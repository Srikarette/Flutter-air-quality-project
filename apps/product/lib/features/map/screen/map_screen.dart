import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/widgets/elements/input/search_input.dart';
import 'package:flutter/cupertino.dart';
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

  List<Marker> markers = [];
  String lastUpdate = '';
  LatLng? centerLocation = LatLng(18.787747, 98.9931284);
  late WeatherProjectionService _weatherService;
  late WeatherProjectionService _weatherSearchService;
  WeatherToDisplay? _currentWeather;
  WeatherToDisplayByCity? _currentSearchWeather;
  final _pmValue = [
    '0-50',
    '51-100',
    '101-200',
    '<200',
  ];
  String _dropDownMenu = '0-50';




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
    fetchMarkerFromCity('Dubai');
  }

  Future<void> _fetchCurrentWeather() async {
    try {
      final weatherData = await _weatherService.getCurrentLocationWeather();
      setState(() {
        _currentWeather = weatherData;
        _isLoading = false;
        _hasError = false;
      });
      if (_currentWeather?.cityGeo != null) {
          _currentWeather!.cityGeo;

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
  Future<void> fetchMarkerFromCity(String city) async {
    try {
      final weatherData = await _weatherSearchService.getWeatherDataByCity(city);
      final filteredData = weatherData.weatherDataList?.where((data) {
        final dateTime = DateTime.parse(data.time?.stime ?? '');
        final now = DateTime.now();
        final isWithinPastYear = dateTime.isAfter(now.subtract(Duration(days: dayCounter)));
        final hasAqiData = data.aqi != "-";
        return isWithinPastYear && hasAqiData;
      }).toList() ?? [];

      markers.clear(); // Clear previous markers
      for (var data in filteredData) {
        final List<double> geo = data.geo ?? [];
        final LatLng coordinates = LatLng(geo[0], geo[1]);
        final pm25 = data.aqi ?? '-';
        final stationName = data.station?.name ?? '';

        Color _getColorForPm25(pm25) {
          int value = int.tryParse(pm25) ?? 0;
          if (value >= 0 && value <= 50) {
            return Colors.green;
          } else if (value >= 51 && value <= 100) {
            return Colors.amberAccent;
          } else if (value >= 101 && value <= 200) {
            return Colors.red;
          } else {
            return Colors.purpleAccent;
          }
        }

        if (pm25 != '-') {
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
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getColorForPm25(pm25),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    pm25,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
      setState(() {}); // Update the UI with new markers
    } catch (error) {
      print("Error fetching markers: $error");
    }
  }


  @override
  Widget build(BuildContext context) {


    String updateTime = 'Unknown';
    if (_currentWeather?.updateTime != null) {
      updateTime = formatDateTime(_currentWeather!.updateTime);
    }

    return Scaffold(
      body: centerLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                CustomSearchInput( // Place CustomSearchInput at the top
                  placeHolder: 'Search',
                  controller: TextEditingController(),
                  onSubmitted: (value) {
                    // Handle search submission
                  },
                ),
                FlutterMap(
                  options: MapOptions(
                    initialCenter: _currentWeather!.cityGeo != null
                        ? _currentWeather!.cityGeo
                        : LatLng(0, 0),
                    initialZoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: markers)
                  ],

                ),
                Positioned(
                  top: 16.0,
                  right: 40.0,
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "Data at "+updateTime,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16.0,
                  left: 30.0,
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
                )

              ],
            ),
    );
  }
}
