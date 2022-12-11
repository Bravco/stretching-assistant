import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Libaries
import 'package:wakelock/wakelock.dart';

//Pages
import 'package:app/page/stretchings/stretchings.dart';
import 'package:app/page/timer/timer.dart';

int pageIndex = 0;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: utils.color10),
      ),
      home: const SafeArea(
        top: false,
        child: Page(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  int selectedIndex = 0;

  final pages = [
    const StretchingsPage(),
    const TimerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.color60,
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement_rounded),
            label: "Stretchings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Timer",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() => selectedIndex = index);
        },
        showUnselectedLabels: false,
        backgroundColor: utils.color30,
        selectedItemColor: utils.color10,
        selectedIconTheme: const IconThemeData(
          size: 32,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        unselectedItemColor: utils.color0Alt,
      ),
    );
  }
}