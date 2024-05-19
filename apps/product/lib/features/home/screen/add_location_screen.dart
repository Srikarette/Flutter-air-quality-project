import 'package:core_ui/theme/theme_provider.dart';
import 'package:core_ui/widgets/elements/input/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:product/features/home/data/models/favorite.dart';
import 'package:product/features/home/data/models/home_view_model.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  return dateFormat.format(dateTime);
}

String formatDateDay(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat dateFormat = DateFormat('EEEE');
  return dateFormat.format(dateTime);
}

class AddLocationScreen extends ConsumerStatefulWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends ConsumerState<AddLocationScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndFetchWeather();
  }

  Future<void> _checkLocationPermissionAndFetchWeather() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permission denied.');
      return;
    }

    Position? position = await Geolocator.getCurrentPosition();
    if (position != null) {
      final viewModel = ref.read(homeViewModelProvider.notifier);
      await viewModel.fetchCurrentWeatherByLatLng(position.latitude, position.longitude);
    } else {
      print('Failed to get user location.');
    }
  }

  void addToFavorites(num? uid, String? name, String? country, String? aqi, String? stime) async {
    var box = Hive.box<Favorite>('favorites');
    var favorite = Favorite(
        uid: uid, name: name, country: country, aqi: aqi, stime: stime);
    await box.put(uid, favorite);
  }

  void _showBookmarkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Success',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          content: const Text('Added to bookmarks successfully!'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final theme = ref.watch(appThemeProvider).themeColor;
        final state = ref.watch(homeViewModelProvider);

        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            title: Text(
              'Add Bookmarks',
              style: TextStyle(
                color: theme.text,
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
              ),
            ),
            backgroundColor: theme.backgroundSky,
          ),
          body: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSearchInput(
                            placeHolder: 'Search city',
                            controller: _searchController,
                            onSubmitted: (city) async {
                              final viewModel = ref.read(homeViewModelProvider.notifier);
                              await viewModel.searchWeatherByCity(city);
                            },
                            width: 350,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (state.currentSearchWeather != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.currentSearchWeather!.weatherDataList!.map((weatherData) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  addToFavorites(
                                    weatherData.uid,
                                    weatherData.station?.name,
                                    weatherData.station?.country,
                                    weatherData.aqi,
                                    weatherData.time?.stime,
                                  );
                                  _showBookmarkDialog(context);
                                },
                                child: CardSearchStatus(
                                  dailyAvg: weatherData.aqi ?? 'Unknown',
                                  city: weatherData.station?.name ?? 'Unknown',
                                  updateTime: weatherData.time?.stime ?? 'Unknown',
                                ),
                              ),
                            ],
                          );
                        }),
                        if (state.loading)
                          Visibility(
                            visible: state.loading,
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              if (state.loading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
