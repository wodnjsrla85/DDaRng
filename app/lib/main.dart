import 'package:app/model/station.dart';
import 'package:app/view/home.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('bycle');

  final prefs = await SharedPreferences.getInstance();
  final isFirstRun = prefs.getBool('isFirstRun') ?? true;

  if (isFirstRun) {
    await loadAndStoreCsvInHive(); // 최초 실행 시에만 데이터 삽입
    await prefs.setBool('isFirstRun', false); // 다음 실행부턴 실행 안 됨
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}

Future<void> loadAndStoreCsvInHive() async {
  // 1. CSV 파일 읽기
  final rawData = await rootBundle.loadString('assets/서대문구_대여소_위치정보.csv');

  // CSV 파싱
  List<List<dynamic>> csvData = const CsvToListConverter().convert(rawData);

  // 헤더는 첫 줄이므로 제외
  final dataRows = csvData.skip(1);

  final stationBox = await Hive.openBox<Station>('stationBox');

  if (stationBox.isEmpty) {
    for (var row in dataRows) {
      // 예: [ID, 이름, 위도, 경도]
      final station = Station(
        st_name: row[0].toString(),
        st_adress: row[1].toString(),
        st_lat: double.parse(row[2].toString()),
        st_long: double.parse(row[3].toString()),
      );
      await stationBox.add(station);
    }
    print('초기 데이터 저장 완료!');
  } else {
    print('이미 저장된 데이터가 있습니다.');
  }

  await stationBox.close();
}
