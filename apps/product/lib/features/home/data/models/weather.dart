class AirQualityData {
  AirQualityData({
    this.status,
    this.data,});

  AirQualityData.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  Data? data;
  AirQualityData copyWith({  String? status,
    Data? data,
  }) => AirQualityData(  status: status ?? this.status,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.aqi,
    this.idx,
    this.attributions,
    this.city,
    this.dominentpol,
    this.iaqi,
    this.time,
    this.forecast,
    this.debug,});

  Data.fromJson(dynamic json) {
    aqi = json['aqi'];
    idx = json['idx'];
    if (json['attributions'] != null) {
      attributions = [];
      json['attributions'].forEach((v) {
        attributions?.add(Attributions.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    dominentpol = json['dominentpol'];
    iaqi = json['iaqi'] != null ? Iaqi.fromJson(json['iaqi']) : null;
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    forecast = json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;
    debug = json['debug'] != null ? Debug.fromJson(json['debug']) : null;
  }
  num? aqi;
  num? idx;
  List<Attributions>? attributions;
  City? city;
  String? dominentpol;
  Iaqi? iaqi;
  Time? time;
  Forecast? forecast;
  Debug? debug;
  Data copyWith({  num? aqi,
    num? idx,
    List<Attributions>? attributions,
    City? city,
    String? dominentpol,
    Iaqi? iaqi,
    Time? time,
    Forecast? forecast,
    Debug? debug,
  }) => Data(  aqi: aqi ?? this.aqi,
    idx: idx ?? this.idx,
    attributions: attributions ?? this.attributions,
    city: city ?? this.city,
    dominentpol: dominentpol ?? this.dominentpol,
    iaqi: iaqi ?? this.iaqi,
    time: time ?? this.time,
    forecast: forecast ?? this.forecast,
    debug: debug ?? this.debug,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aqi'] = aqi;
    map['idx'] = idx;
    if (attributions != null) {
      map['attributions'] = attributions?.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      map['city'] = city?.toJson();
    }
    map['dominentpol'] = dominentpol;
    if (iaqi != null) {
      map['iaqi'] = iaqi?.toJson();
    }
    if (time != null) {
      map['time'] = time?.toJson();
    }
    if (forecast != null) {
      map['forecast'] = forecast?.toJson();
    }
    if (debug != null) {
      map['debug'] = debug?.toJson();
    }
    return map;
  }

}

class Debug {
  Debug({
    this.sync,});

  Debug.fromJson(dynamic json) {
    sync = json['sync'];
  }
  String? sync;
  Debug copyWith({  String? sync,
  }) => Debug(  sync: sync ?? this.sync,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sync'] = sync;
    return map;
  }

}

class Forecast {
  Forecast({
    this.daily,});

  Forecast.fromJson(dynamic json) {
    daily = json['daily'] != null ? Daily.fromJson(json['daily']) : null;
  }
  Daily? daily;
  Forecast copyWith({  Daily? daily,
  }) => Forecast(  daily: daily ?? this.daily,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (daily != null) {
      map['daily'] = daily?.toJson();
    }
    return map;
  }

}

class Daily {
  Daily({
    this.o3,
    this.pm10,
    this.pm25,
    this.uvi,});

  Daily.fromJson(dynamic json) {
    if (json['o3'] != null) {
      o3 = [];
      json['o3'].forEach((v) {
        o3?.add(O3.fromJson(v));
      });
    }
    if (json['pm10'] != null) {
      pm10 = [];
      json['pm10'].forEach((v) {
        pm10?.add(Pm10.fromJson(v));
      });
    }
    if (json['pm25'] != null) {
      pm25 = [];
      json['pm25'].forEach((v) {
        pm25?.add(Pm25.fromJson(v));
      });
    }
    if (json['uvi'] != null) {
      uvi = [];
      json['uvi'].forEach((v) {
        uvi?.add(Uvi.fromJson(v));
      });
    }
  }
  List<O3>? o3;
  List<Pm10>? pm10;
  List<Pm25>? pm25;
  List<Uvi>? uvi;
  Daily copyWith({  List<O3>? o3,
    List<Pm10>? pm10,
    List<Pm25>? pm25,
    List<Uvi>? uvi,
  }) => Daily(  o3: o3 ?? this.o3,
    pm10: pm10 ?? this.pm10,
    pm25: pm25 ?? this.pm25,
    uvi: uvi ?? this.uvi,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (o3 != null) {
      map['o3'] = o3?.map((v) => v.toJson()).toList();
    }
    if (pm10 != null) {
      map['pm10'] = pm10?.map((v) => v.toJson()).toList();
    }
    if (pm25 != null) {
      map['pm25'] = pm25?.map((v) => v.toJson()).toList();
    }
    if (uvi != null) {
      map['uvi'] = uvi?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Uvi {
  Uvi({
    this.avg,
    this.day,
    this.max,
    this.min,});

  Uvi.fromJson(dynamic json) {
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }
  num? avg;
  String? day;
  num? max;
  num? min;
  Uvi copyWith({  num? avg,
    String? day,
    num? max,
    num? min,
  }) => Uvi(  avg: avg ?? this.avg,
    day: day ?? this.day,
    max: max ?? this.max,
    min: min ?? this.min,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avg'] = avg;
    map['day'] = day;
    map['max'] = max;
    map['min'] = min;
    return map;
  }

}

class Pm25 {
  Pm25({
    this.avg,
    this.day,
    this.max,
    this.min,});

  Pm25.fromJson(dynamic json) {
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }
  num? avg;
  String? day;
  num? max;
  num? min;
  Pm25 copyWith({  num? avg,
    String? day,
    num? max,
    num? min,
  }) => Pm25(  avg: avg ?? this.avg,
    day: day ?? this.day,
    max: max ?? this.max,
    min: min ?? this.min,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avg'] = avg;
    map['day'] = day;
    map['max'] = max;
    map['min'] = min;
    return map;
  }

}

class Pm10 {
  Pm10({
    this.avg,
    this.day,
    this.max,
    this.min,});

  Pm10.fromJson(dynamic json) {
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }
  num? avg;
  String? day;
  num? max;
  num? min;
  Pm10 copyWith({  num? avg,
    String? day,
    num? max,
    num? min,
  }) => Pm10(  avg: avg ?? this.avg,
    day: day ?? this.day,
    max: max ?? this.max,
    min: min ?? this.min,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avg'] = avg;
    map['day'] = day;
    map['max'] = max;
    map['min'] = min;
    return map;
  }

}

class O3 {
  O3({
    this.avg,
    this.day,
    this.max,
    this.min,});

  O3.fromJson(dynamic json) {
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }
  num? avg;
  String? day;
  num? max;
  num? min;
  O3 copyWith({  num? avg,
    String? day,
    num? max,
    num? min,
  }) => O3(  avg: avg ?? this.avg,
    day: day ?? this.day,
    max: max ?? this.max,
    min: min ?? this.min,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avg'] = avg;
    map['day'] = day;
    map['max'] = max;
    map['min'] = min;
    return map;
  }

}

class Time {
  Time({
    this.s,
    this.tz,
    this.v,
    this.iso,});

  Time.fromJson(dynamic json) {
    s = json['s'];
    tz = json['tz'];
    v = json['v'];
    iso = json['iso'];
  }
  String? s;
  String? tz;
  num? v;
  String? iso;
  Time copyWith({  String? s,
    String? tz,
    num? v,
    String? iso,
  }) => Time(  s: s ?? this.s,
    tz: tz ?? this.tz,
    v: v ?? this.v,
    iso: iso ?? this.iso,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['s'] = s;
    map['tz'] = tz;
    map['v'] = v;
    map['iso'] = iso;
    return map;
  }

}

class Iaqi {
  Iaqi({
    this.h,
    this.no2,
    this.o3,
    this.p,
    this.pm10,
    this.pm25,
    this.r,
    this.so2,
    this.t,
    this.w,});

  Iaqi.fromJson(dynamic json) {
    h = json['h'] != null ? H.fromJson(json['h']) : null;
    no2 = json['no2'] != null ? No2.fromJson(json['no2']) : null;
    o3 = json['o3'] != null ? O3.fromJson(json['o3']) : null;
    p = json['p'] != null ? P.fromJson(json['p']) : null;
    pm10 = json['pm10'] != null ? Pm10.fromJson(json['pm10']) : null;
    pm25 = json['pm25'] != null ? Pm25.fromJson(json['pm25']) : null;
    r = json['r'] != null ? R.fromJson(json['r']) : null;
    so2 = json['so2'] != null ? So2.fromJson(json['so2']) : null;
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    w = json['w'] != null ? W.fromJson(json['w']) : null;
  }
  H? h;
  No2? no2;
  O3? o3;
  P? p;
  Pm10? pm10;
  Pm25? pm25;
  R? r;
  So2? so2;
  T? t;
  W? w;
  Iaqi copyWith({  H? h,
    No2? no2,
    O3? o3,
    P? p,
    Pm10? pm10,
    Pm25? pm25,
    R? r,
    So2? so2,
    T? t,
    W? w,
  }) => Iaqi(  h: h ?? this.h,
    no2: no2 ?? this.no2,
    o3: o3 ?? this.o3,
    p: p ?? this.p,
    pm10: pm10 ?? this.pm10,
    pm25: pm25 ?? this.pm25,
    r: r ?? this.r,
    so2: so2 ?? this.so2,
    t: t ?? this.t,
    w: w ?? this.w,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (h != null) {
      map['h'] = h?.toJson();
    }
    if (no2 != null) {
      map['no2'] = no2?.toJson();
    }
    if (o3 != null) {
      map['o3'] = o3?.toJson();
    }
    if (p != null) {
      map['p'] = p?.toJson();
    }
    if (pm10 != null) {
      map['pm10'] = pm10?.toJson();
    }
    if (pm25 != null) {
      map['pm25'] = pm25?.toJson();
    }
    if (r != null) {
      map['r'] = r?.toJson();
    }
    if (so2 != null) {
      map['so2'] = so2?.toJson();
    }
    if (t != null) {
      map['t'] = t?.toJson();
    }
    if (w != null) {
      map['w'] = w?.toJson();
    }
    return map;
  }

}

class W {
  W({
    this.v,});

  W.fromJson(dynamic json) {
    v = json['v'];
  }
  num? v;
  W copyWith({  num? v,
  }) => W(  v: v ?? this.v,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    return map;
  }

}

class T {
  T({
    this.v,});

  T.fromJson(dynamic json) {
    v = json['v'];
  }
  num? v;
  T copyWith({  num? v,
  }) => T(  v: v ?? this.v,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    return map;
  }

}

class So2 {
  So2({
    this.v,});

  So2.fromJson(dynamic json) {
    v = json['v'];
  }
  num? v;
  So2 copyWith({  num? v,
  }) => So2(  v: v ?? this.v,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    return map;
  }

}

class R {
  R({
    this.v,});

  R.fromJson(dynamic json) {
    v = json['v'];
  }
  num? v;
  R copyWith({  num? v,
  }) => R(  v: v ?? this.v,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    return map;
  }

}

class P {
  P({
    this.v,});

  P.fromJson(dynamic json) {
    v = json['v'];
  }
  num? v;
  P copyWith({  num? v,
  }) => P(  v: v ?? this.v,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    return map;
  }

}

class No2 {
  No2({
    this.v,});

  No2.fromJson(dynamic json) {
    v = json['v'];
  }
  num? v;
  No2 copyWith({  num? v,
  }) => No2(  v: v ?? this.v,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    return map;
  }

}

class H {
  H({
    this.v,});

  H.fromJson(dynamic json) {
    v = json['v'];
  }
  num? v;
  H copyWith({  num? v,
  }) => H(  v: v ?? this.v,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    return map;
  }

}

class City {
  City({
    this.geo,
    this.name,
    this.url,
    this.location,});

  City.fromJson(dynamic json) {
    geo = json['geo'] != null ? json['geo'].cast<num>() : [];
    name = json['name'];
    url = json['url'];
    location = json['location'];
  }
  List<num>? geo;
  String? name;
  String? url;
  String? location;
  City copyWith({  List<num>? geo,
    String? name,
    String? url,
    String? location,
  }) => City(  geo: geo ?? this.geo,
    name: name ?? this.name,
    url: url ?? this.url,
    location: location ?? this.location,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['geo'] = geo;
    map['name'] = name;
    map['url'] = url;
    map['location'] = location;
    return map;
  }

}

class Attributions {
  Attributions({
    this.url,
    this.name,
    this.logo,});

  Attributions.fromJson(dynamic json) {
    url = json['url'];
    name = json['name'];
    logo = json['logo'];
  }
  String? url;
  String? name;
  String? logo;
  Attributions copyWith({  String? url,
    String? name,
    String? logo,
  }) => Attributions(  url: url ?? this.url,
    name: name ?? this.name,
    logo: logo ?? this.logo,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['name'] = name;
    map['logo'] = logo;
    return map;
  }

}