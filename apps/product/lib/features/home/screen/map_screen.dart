import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];
  String lastUpdate = '';
  double initialZoom = 0;
  LatLng? centerLocation = LatLng(18.787747, 98.9931284);

  @override
  void initState() {
    super.initState();
    fetchTimeAt();
    fetchMarker();
    initialZoom;
  }

  Future<void> fetchMarker() async {
    const apiUrl =
        'https://api.waqi.info/search/?token=2190be2f9c41f96905ba4fc092a664c0ad2d87b4&keyword=chiangmai';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> stations = data['data'];
        for (var station in stations) {
          final List<double> geo = station['station']['geo'].cast<double>();
          final LatLng coordinates = LatLng(geo[0], geo[1]);
          final pm25 = station['aqi'] ?? '-';
          Color _getColorForPm25(pm25){
            int value = int.parse(pm25);
            if (value >= 0 && value <= 50) {
              return Colors.green;
            } else if (value >= 51 && value <= 100) {
              return Colors.amberAccent;
            } else if (value >= 101 && value <= 200) {
              return Colors.red;
            }else {
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
                    // Show a popup or tooltip here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(pm25),
                          content: Text('Popup content here'),
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
                      color: _getColorForPm25('202'),
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
        setState(() {});
      } else {
        print('API request failed with status ${response.statusCode}');
      }
    } catch (e) {
      print("Error $e");
    }
  }

  Future<void> fetchTimeAt() async {
    const apiUrl =
        'https://api.waqi.info/feed/here/?token=2190be2f9c41f96905ba4fc092a664c0ad2d87b4';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          lastUpdate = data['data']['time']['s'].split(" ")[1];
        });
      } else {
        print('API request failed with status ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: centerLocation == null
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: centerLocation!,
              initialZoom: 14,
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
                  'Data at $lastUpdate',
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
            left: 40.0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_road_rounded),
                    SizedBox(width: 8.0),
                    Text(
                      'Select city  ',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}