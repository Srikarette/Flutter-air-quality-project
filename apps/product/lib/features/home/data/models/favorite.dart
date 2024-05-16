import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite {
  @HiveField(0)
  final int uid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String country;

  Favorite({required this.uid, required this.name, required this.country});
}
