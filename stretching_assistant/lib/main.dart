import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';
import 'package:stretching_assistant/theme.dart';

// Data
import 'package:stretching_assistant/data/trainings.dart';

// Page
import 'package:stretching_assistant/page/home.dart';
import 'package:stretching_assistant/page/timer/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    for (var training in trainings) {
      precacheImage(training.image, context);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.themeData,
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
        selectedIconTheme: const IconThemeData(
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