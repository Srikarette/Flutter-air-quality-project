

import 'package:product/features/home/data/models/weather.dart';
import 'package:latlong2/latlong.dart';

class WeatherToDisplay {
  String cityName;
  List<Pm25> pm25Forecast;
  String updateTime;
  LatLng cityGeo;

  WeatherToDisplay({
    required this.cityName,
    required this.pm25Forecast,
    required this.updateTime,
    required this.cityGeo,
  });

  factory WeatherToDisplay.fromAirQualityData(AirQualityData airQualityData) {
    String cityName = airQualityData.data?.city?.name ?? "";
    String updateTime = airQualityData.data?.time?.iso ?? "";

    List<Pm25> pm25Forecast = [];
    if (airQualityData.data?.forecast?.daily?.pm25 != null) {
      pm25Forecast = airQualityData.data!.forecast!.daily!.pm25!;
    }

    List<num>? geoList = airQualityData.data?.city?.geo;
    double latitude = 0.0;
    double longitude = 0.0;

    // Check if geoList is not null and has at least two elements
    if (geoList != null && geoList.length >= 2) {
      // Convert the first and second elements of geoList to double
      latitude = geoList[0].toDouble();
      longitude = geoList[1].toDouble();
    }

    LatLng geo = LatLng(latitude, longitude);

    return WeatherToDisplay(
      cityName: cityName,
      pm25Forecast: pm25Forecast,
      updateTime: updateTime,
      cityGeo: geo,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'pm25Forecast': pm25Forecast.map((pm25) => pm25.toJson()).toList(),
      'updateTime': updateTime,
      'cityGeo': cityGeo,
    };
  }
}
