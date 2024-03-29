import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';
import 'package:stretching_assistant/ads.dart';

// Pub
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Model
import 'package:stretching_assistant/model/duration.dart';
import 'package:stretching_assistant/model/exercise.dart';
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/exercises.dart';

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
  MobileAds.instance.initialize();
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
  void initState() {
    super.initState();
    createInterstitialAd();
    loadExercises().then((value) => setState(() => exercises = value));
  }

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
          showInterstitialAd(random: true, probability: 1/2);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}