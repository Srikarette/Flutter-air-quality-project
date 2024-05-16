import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/widgets/elements/botton/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:product/features/home/presentation/widgets/component/app-bar.dart';
import 'package:product/features/home/presentation/widgets/component/card_status.dart';
import 'package:product/features/home/screen/add_location_screen.dart';
import 'package:product/features/home/screen/manage_location_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

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
     final dailyForecast = _currentWeather?.pm25Forecast[2];
     final tomorrowForecast = _currentWeather?.pm25Forecast[3];
     final dayAfterTomorrowForecast = _currentWeather?.pm25Forecast[4];
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white70,
        appBar: CustomAppBar(),
        body: Column(
          children: <Widget>[
            SizedBox(height: 16),
              if (dailyForecast != null && tomorrowForecast != null && dayAfterTomorrowForecast != null)
            CardStatus(
              dailyAvg: dailyForecast.avg ?? 0,
              tomorrowAvg: tomorrowForecast.avg ?? 0,
              dayAfterTomorrowAvg: dayAfterTomorrowForecast.avg ?? 0,
              city: _currentWeather?.cityName ?? 'Unknown',
              updateTime: _currentWeather?.updateTime ?? 'Unknown',
              tomorrowDay:tomorrowForecast.day ?? 'Unknown',
              dayAfterTomorrowDay:dayAfterTomorrowForecast.day ?? 'Unknown',
            ),
            SizedBox(height: 16),
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
                          builder: (context) => const AddLocationScreen()),
                    );
                  },
                ),
                SizedBox(width: 16), // ระยะห่างระหว่างปุ่ม
                PrimaryButton(
                  title: 'MANAGE',
                  titleColor: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}