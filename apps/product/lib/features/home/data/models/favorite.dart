import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
  @HiveField(0)
  num? uid;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? country;

  @HiveField(3)
  String? aqi;

  @HiveField(4)
  String? stime;

  Favorite({
    required this.uid,
    required this.name,
    required this.country,
    required this.aqi,
    required this.stime,
  });
}
