class AirQualityDataByCity {
  AirQualityDataByCity({
    this.status,
    this.data,});

  AirQualityDataByCity.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  String? status;
  List<Data>? data;
  AirQualityDataByCity copyWith({  String? status,
    List<Data>? data,
  }) => AirQualityDataByCity(  status: status ?? this.status,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
    this.uid,
    this.aqi,
    this.time,
    this.station,});

  Data.fromJson(dynamic json) {
    uid = json['uid'];
    aqi = json['aqi'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    station = json['station'] != null ? Station.fromJson(json['station']) : null;
  }
  num? uid;
  String? aqi;
  Time? time;
  Station? station;
  Data copyWith({  num? uid,
    String? aqi,
    Time? time,
    Station? station,
  }) => Data(  uid: uid ?? this.uid,
    aqi: aqi ?? this.aqi,
    time: time ?? this.time,
    station: station ?? this.station,
  );
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
    return map;
  }

}

class Station {
  Station({
    this.name,
    this.geo,
    this.url,
    this.country,});

  Station.fromJson(dynamic json) {
    name = json['name'];
    geo = json['geo'] != null ? json['geo'].cast<num>() : [];
    url = json['url'];
    country = json['country'];
  }
  String? name;
  List<num>? geo;
  String? url;
  String? country;
  Station copyWith({  String? name,
    List<num>? geo,
    String? url,
    String? country,
  }) => Station(  name: name ?? this.name,
    geo: geo ?? this.geo,
    url: url ?? this.url,
    country: country ?? this.country,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['geo'] = geo;
    map['url'] = url;
    map['country'] = country;
    return map;
  }

}

class Time {
  Time({
    this.tz,
    this.stime,
    this.vtime,});

  Time.fromJson(dynamic json) {
    tz = json['tz'];
    stime = json['stime'];
    vtime = json['vtime'];
  }
  String? tz;
  String? stime;
  num? vtime;
  Time copyWith({  String? tz,
    String? stime,
    num? vtime,
  }) => Time(  tz: tz ?? this.tz,
    stime: stime ?? this.stime,
    vtime: vtime ?? this.vtime,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tz'] = tz;
    map['stime'] = stime;
    map['vtime'] = vtime;
    return map;
  }
}