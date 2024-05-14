import 'dart:convert';
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
  List<LatLng> polylinePoints = []; // Store your polyline points here
  String lastUpdate = ''; // Store the last update date here

  @override
  void initState() {
    super.initState();
    fetchAndCreatePolyline();
  }

  Future<void> fetchAndCreatePolyline() async {
    const apiUrl =
        'https://api.waqi.info/feed/chiangmai/?token=2190be2f9c41f96905ba4fc092a664c0ad2d87b4'; // Replace with the actual API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Extract latitude and longitude points

        final List<double> geo = data['data']['city']['geo'].cast<double>();
        final LatLng coordinates = LatLng(geo[0], geo[1]);
        print(coordinates);
        setState(() {
          polylinePoints.add(coordinates);
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
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(18.787747, 98.9931284),
              initialZoom: 9,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points:
                        polylinePoints, // Use the fetched polyline points here
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              top: 16.0,
              right: 40.0,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Data at $lastUpdate',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
          Positioned(
            top: 16.0,
            left: 40.0,
            child: SafeArea(
                child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.add_road_rounded),
            )),
          )
        ],
      ),
    );
  }
}
