import 'package:app/model/station.dart';
import 'package:app/view/home.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StationAdapter());
  final prefs = await SharedPreferences.getInstance();
  final isFirstRun = prefs.getBool('isFirstRun') ?? true;

  final stationBox = await Hive.openBox<Station>('bycle');

  if (isFirstRun) {
    await loadAndStoreCsvInHive(stationBox); // 박스를 전달해서 사용
    await prefs.setBool('isFirstRun', false);
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
    return GetMaterialApp(
      // Responsive Breakpoints 설정 (가로 기준)
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              Breakpoint(start: 0, end: 450, name: MOBILE),
              Breakpoint(start: 451, end: 800, name: TABLET),
              Breakpoint(start: 801, end: 1920, name: DESKTOP),
              Breakpoint(
                start: 1921,
                end: double.infinity,
                name: '4K',
              ), // 1920 이상은 4K 라는 이름으로 하겠다.
            ],
          ),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}

Future<void> loadAndStoreCsvInHive(Box<Station> stationBox) async {
  final rawData = await rootBundle.loadString('assets/서대문구_대여소_위치정보.csv');
  List<List<dynamic>> csvTable = const CsvToListConverter(
    eol: '\n',
    shouldParseNumbers: false,
  ).convert(rawData);

  // List<List<dynamic>> csvData =
  //     lines.map((line) {
  //       return const CsvToListConverter().convert(line).first;
  //     }).toList();
  final dataRows = csvTable.skip(1);

  if (stationBox.isEmpty) {
    for (var row in dataRows) {
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
}
