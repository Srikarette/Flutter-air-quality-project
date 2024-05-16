import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:product/features/home/data/models/favorite.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<dynamic> locations = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://api.waqi.info/search/?token=2190be2f9c41f96905ba4fc092a664c0ad2d87b4&keyword=chiangmai'));
    if (response.statusCode == 200) {
      setState(() {
        locations = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void addToFavorites(int uid, String name, String country) async {
    var box = Hive.box<Favorite>('favorites');
    var favorite = Favorite(uid: uid, name: name, country: country);
    print(favorite.name);
    box.put(uid, favorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locations')),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          var location = locations[index];
          return Card(
            child: ListTile(
              title: Text(location['station']['name']),
              subtitle: Text(location['station']['country']),
              trailing: const Icon(Icons.favorite_border),
              onTap: () {
                addToFavorites(
                  location['uid'],
                  location['station']['name'],
                  location['station']['country'],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
