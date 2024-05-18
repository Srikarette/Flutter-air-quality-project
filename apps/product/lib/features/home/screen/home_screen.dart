import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/theme/theme_provider.dart';
import 'package:core_ui/widgets/composes/navbar/app-bar.dart';
import 'package:core_ui/widgets/elements/botton/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product/features/home/data/models/home_view_model.dart';
import 'package:product/features/home/domain/entities/weatherToDisplay.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:product/features/home/presentation/widgets/component/card_status.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';
import 'package:product/features/home/screen/add_location_screen.dart';
import 'package:intl/intl.dart';
import 'package:product/features/home/screen/favotire_list_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).fetchCurrentWeather();
    });
  }

  String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return 'Unknown';
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(dateTime);
  }

  String formatDateDay(String? dateTimeString) {
    if (dateTimeString == null) return 'Unknown';
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat dateFormat = DateFormat('EEEE');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final theme = ref.watch(appThemeProvider).themeColor;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: theme.backgroundPrimary,
        appBar: CustomAppBar(
          searchController: _searchController,
          onSearchSubmitted: (city) {
            ref.read(homeViewModelProvider.notifier).searchWeatherByCity(city);
          },
        ),
        body: Stack(
          
          children: [
            if (state.loading) const Center(child: CircularProgressIndicator()),
            if (!state.loading && state.currentWeather != null) Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CardStatus(
                    dailyAvg: state.currentWeather!.pm25Forecast[2].avg ?? 0,
                    tomorrowAvg: state.currentWeather!.pm25Forecast[3].avg ?? 0,
                    dayAfterTomorrowAvg: state.currentWeather!.pm25Forecast[4].avg ?? 0,
                    city: state.currentWeather!.cityName,
                    updateTime: formatDateTime(state.currentWeather!.updateTime),
                    tomorrowDay: formatDateDay(state.currentWeather!.pm25Forecast[3].day),
                    dayAfterTomorrowDay: formatDateDay(state.currentWeather!.pm25Forecast[4].day),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        title: 'Add Bookmarks',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddLocationScreen()),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      PrimaryButton(
                        title: 'Bookmarks',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FavoriteList()),
                          );
                        },
                      ),
                    ],
                  ),
                  const Text(
                    'Search result',
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (state.currentSearchWeather != null) Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: state.currentSearchWeather!.weatherDataList!.map((weatherData) {
                                return CardSearchStatus(
                                  dailyAvg: weatherData.aqi ?? 'Unknown',
                                  city: weatherData.station?.name ?? 'Unknown',
                                  updateTime: weatherData.time?.stime ?? 'Unknown',
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
