import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Pub
import 'package:hive_flutter/hive_flutter.dart';

// Model
import 'package:stretching_assistant/model/duration.dart';
import 'package:stretching_assistant/model/exercise.dart';
import 'package:stretching_assistant/model/training.dart';

// Page
import 'package:stretching_assistant/page/home.dart';
import 'package:stretching_assistant/page/timer/timer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DurationAdapter());
  Hive.registerAdapter(ExerciseEntryAdapter());
  Hive.registerAdapter(TrainingAdapter());
  await Hive.openBox<Training>("customTrainings");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Utils.themeData,
      home: const SafeArea(
        child: Page(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final pages = [
    const HomePage(),
    const TimerPage(),
  ];
  
  int pageIndex = 0;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Timer",
          ),
        ],
        backgroundColor: Utils.secondaryBackgroundColor,
        selectedIconTheme: IconThemeData(
          size: 32,
          color: Utils.primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          size: 28,
          color: Utils.textColorAlt,
        ),
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(() => pageIndex = index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}