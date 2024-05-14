class AirQualityData {
  String status;
  Data data;

  AirQualityData({required this.status, required this.data});

  factory AirQualityData.fromJson(Map<String, dynamic> json) {
    return AirQualityData(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class Data {
  int aqi;
  int idx;
  List<Attribution> attributions;
  City city;
  String dominentpol;
  Iaqi iaqi;
  Time time;
  Forecast forecast;

  Data({
    required this.aqi,
    required this.idx,
    required this.attributions,
    required this.city,
    required this.dominentpol,
    required this.iaqi,
    required this.time,
    required this.forecast,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var attributionsList = json['attributions'] as List;
    List<Attribution> attributions = attributionsList.map((i) => Attribution.fromJson(i)).toList();

    return Data(
      aqi: json['aqi'],
      idx: json['idx'],
      attributions: attributions,
      city: City.fromJson(json['city']),
      dominentpol: json['dominentpol'],
      iaqi: Iaqi.fromJson(json['iaqi']),
      time: Time.fromJson(json['time']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aqi': aqi,
      'idx': idx,
      'attributions': attributions.map((i) => i.toJson()).toList(),
      'city': city.toJson(),
      'dominentpol': dominentpol,
      'iaqi': iaqi.toJson(),
      'time': time.toJson(),
      'forecast': forecast.toJson(),
    };
  }
}

class Attribution {
  String url;
  String name;
  String? logo;

  Attribution({required this.url, required this.name, this.logo});

  factory Attribution.fromJson(Map<String, dynamic> json) {
    return Attribution(
      url: json['url'],
      name: json['name'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'logo': logo,
    };
  }
}

class City {
  List<double> geo;
  String name;
  String url;
  String location;

  City({required this.geo, required this.name, required this.url, required this.location});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      geo: List<double>.from(json['geo']),
      name: json['name'],
      url: json['url'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geo': geo,
      'name': name,
      'url': url,
      'location': location,
    };
  }
}

class Iaqi {
  IaqiValue h;
  IaqiValue no2;
  IaqiValue o3;
  IaqiValue p;
  IaqiValue pm10;
  IaqiValue pm25;
  IaqiValue so2;
  IaqiValue t;
  IaqiValue w;

  Iaqi({
    required this.h,
    required this.no2,
    required this.o3,
    required this.p,
    required this.pm10,
    required this.pm25,
    required this.so2,
    required this.t,
    required this.w,
  });

  factory Iaqi.fromJson(Map<String, dynamic> json) {
    return Iaqi(
      h: IaqiValue.fromJson(json['h']),
      no2: IaqiValue.fromJson(json['no2']),
      o3: IaqiValue.fromJson(json['o3']),
      p: IaqiValue.fromJson(json['p']),
      pm10: IaqiValue.fromJson(json['pm10']),
      pm25: IaqiValue.fromJson(json['pm25']),
      so2: IaqiValue.fromJson(json['so2']),
      t: IaqiValue.fromJson(json['t']),
      w: IaqiValue.fromJson(json['w']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'h': h.toJson(),
      'no2': no2.toJson(),
      'o3': o3.toJson(),
      'p': p.toJson(),
      'pm10': pm10.toJson(),
      'pm25': pm25.toJson(),
      'so2': so2.toJson(),
      't': t.toJson(),
      'w': w.toJson(),
    };
  }
}

class IaqiValue {
  double v;

  IaqiValue({required this.v});

  factory IaqiValue.fromJson(Map<String, dynamic> json) {
    return IaqiValue(
      v: json['v'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'v': v,
    };
  }
}

class Time {
  String s;
  String tz;
  int v;
  String iso;

  Time({required this.s, required this.tz, required this.v, required this.iso});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      s: json['s'],
      tz: json['tz'],
      v: json['v'],
      iso: json['iso'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's': s,
      'tz': tz,
      'v': v,
      'iso': iso,
    };
  }
}

class Forecast {
  List<Daily> o3;
  List<Daily> pm10;
  List<Daily> pm25;
  List<Uvi> uvi;

  Forecast({required this.o3, required this.pm10, required this.pm25, required this.uvi});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var o3List = json['o3'] as List;
    var pm10List = json['pm10'] as List;
    var pm25List = json['pm25'] as List;
    var uviList = json['uvi'] as List;

    return Forecast(
      o3: o3List.map((i) => Daily.fromJson(i)).toList(),
      pm10: pm10List.map((i) => Daily.fromJson(i)).toList(),
      pm25: pm25List.map((i) => Daily.fromJson(i)).toList(),
      uvi: uviList.map((i) => Uvi.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'o3': o3.map((i) => i.toJson()).toList(),
      'pm10': pm10.map((i) => i.toJson()).toList(),
      'pm25': pm25.map((i) => i.toJson()).toList(),
      'uvi': uvi.map((i) => i.toJson()).toList(),
    };
  }
}

class Daily {
  double avg;
  String day;
  double max;
  double min;

  Daily({required this.avg, required this.day, required this.max, required this.min});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      avg: json['avg'].toDouble(),
      day: json['day'],
      max: json['max'].toDouble(),
      min: json['min'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avg': avg,
      'day': day,
      'max': max,
      'min': min,
    };
  }
}

class Uvi {
  double avg;
  String day;
  double max;
  double min;

  Uvi({required this.avg, required this.day, required this.max, required this.min});

  factory Uvi.fromJson(Map<String, dynamic> json) {
    return Uvi(
      avg: json['avg'].toDouble(),
      day: json['day'],
      max: json['max'].toDouble(),
      min: json['min'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avg': avg,
      'day': day,
      'max': max,
      'min': min,
    };
  }
}
