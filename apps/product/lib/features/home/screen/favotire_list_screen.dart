import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:core_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product/features/home/data/models/favorite.dart';
import 'package:product/features/home/domain/port/service.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  late WeatherProjectionService _weatherSearchService;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _weatherSearchService = getIt.get<WeatherProjectionService>();
    updateFavorites();
  }

  Future<void> updateFavorites() async {
    var box = Hive.box<Favorite>('favorites');
    try {
      for (int i = 0; i < box.length; i++) {
        var favorite = box.getAt(i);
        if (favorite != null) {
          try {
            final weatherData = await _weatherSearchService
                .getWeatherDataByCity(favorite.name.toString());

            if (weatherData.weatherDataList != null) {
              final matchingWeatherData = weatherData.weatherDataList
                  ?.firstWhere((data) => data.uid == favorite.uid);

              if (matchingWeatherData != null) {
                final updatedTime = matchingWeatherData.time?.stime;
                final updatedAqi = matchingWeatherData.aqi;

                if (favorite.stime != updatedTime) {
                  box.putAt(
                    i,
                    Favorite(
                      uid: favorite.uid,
                      name: favorite.name,
                      country: favorite.country,
                      aqi: updatedAqi,
                      stime: updatedTime,
                    ),
                  );
                }
                print('Updated: ' + favorite.name.toString());
              }
            } else {
              print('Failed to fetch data from the service');
            }
          } catch (e) {
            print('Error fetching data for ${favorite.name}: $e');
          }
        }
      }
    } catch (e) {
      print('Error updating favorites: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final color = ref.watch(appThemeProvider).themeColor;
      return Scaffold(
        backgroundColor: color.backgroundPrimary,
         appBar: AppBar(
              title:  Text('Bookmarks',
              style: TextStyle(
                          color: color.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),),
              backgroundColor: color.backgroundSky,
            ),
        body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ValueListenableBuilder(
              valueListenable: Hive.box<Favorite>('favorites').listenable(),
              builder: (context, Box<Favorite> box, _) {
                if (box.values.isEmpty) {
                  return const Center(child: Text('No favorites added.',
              style: TextStyle(
            color: Colors.grey,
          ),));
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    var favorite = box.getAt(index);
                    return Column(
                      children: [
                        const SizedBox(height: 10),Stack(
                          children: [
                            CardSearchStatus(
                              dailyAvg: favorite?.aqi ?? 'Unknown',
                              city: favorite?.name ?? 'Unknown',
                              updateTime: favorite?.stime ?? 'Unknown',
                            ),
                            Positioned(
                              bottom: 10,
                              right: 2,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  box.deleteAt(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );});
  }
}
