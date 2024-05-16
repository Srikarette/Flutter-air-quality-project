import 'package:product/features/home/data/models/weatherByCity.dart';

class WeatherToDisplayByCity {
  String? cityName;
  List<WeatherData>? weatherDataList;

  WeatherToDisplayByCity({
    this.cityName,
    this.weatherDataList,
  });

  factory WeatherToDisplayByCity.fromWeatherByCity(AirQualityDataByCity weatherByCity) {
    String? cityName = weatherByCity.data?.first.station?.name;
    List<WeatherData>? weatherDataList = weatherByCity.data?.map((data) => WeatherData.fromJson(data.toJson())).toList();
    return WeatherToDisplayByCity(
      cityName: cityName,
      weatherDataList: weatherDataList,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cityName'] = cityName;
    if (weatherDataList != null) {
      map['weatherDataList'] = weatherDataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class WeatherData {
  num? uid;
  String? aqi;
  Time? time;
  Station? station;
  List<double>? geo; // Added geo field

  WeatherData({
    this.uid,
    this.aqi,
    this.time,
    this.station,
    this.geo, // Added geo field
  });

  factory WeatherData.fromJson(dynamic json) {
    return WeatherData(
      uid: json['uid'],
      aqi: json['aqi'],
      time: json['time'] != null ? Time.fromJson(json['time']) : null,
      station: json['station'] != null ? Station.fromJson(json['station']) : null,
      geo: json['station'] != null && json['station']['geo'] != null ? List<double>.from(json['station']['geo']) : null, // Added geo field
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['aqi'] = aqi;
    if (time != null) {
      map['time'] = time?.toJson();
    }
    if (station != null) {
      map['station'] = station?.toJson();
    }
    if (geo != null) { // Added geo field
      map['geo'] = geo;
    }
    return map;
  }
}
