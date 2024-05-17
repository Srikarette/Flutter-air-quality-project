import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product/features/home/data/models/favorite.dart';
import 'package:product/infrasturcture/dependency_injection/injector.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(
      FavoriteAdapter());
  await Hive.openBox<Favorite>('favorites'); 
  registerProductServices();
  registerCoreServices();
  runApp(const WeatherHomePage());
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
