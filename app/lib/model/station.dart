import 'package:hive_flutter/hive_flutter.dart';

part 'station.g.dart';

@HiveType(typeId: 1)
class Station {
  @HiveField(0)
  String st_name;
  @HiveField(1)
  String st_adress;
  @HiveField(2)
  double st_lat;
  @HiveField(3)
  double st_long;

  Station({
    required this.st_name,
    required this.st_adress,
    required this.st_lat,
    required this.st_long,
  });
}
