import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'dart:async';

//Data
import 'package:app/data/timer.dart';

//Libaries
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

//Widgets
import 'package:app/widget/appbar.dart';
import 'package:app/widget/outlined_button.dart';

//Pages
import 'package:app/page/timer/settings.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({ Key? key }) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const compressor = 30;
  List<int> times = [];
  int currentLap = 0;
  late int lapsTemp;
  late int cooldownTemp;
  late int workTemp;
  late int restTemp;
  late int maxSecs = cooldownTemp;
  late int secs = cooldownTemp;
  Timer? timer;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();

    if (!mounted) timer?.cancel();

    audioPlayer.open(
      Audio("assets/alarm.mp3"),
      autoStart: false,
      showNotification: false,
    );

    setupTimes();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  void setupTimes() {
    setState(() {
      lapsTemp = laps * 2;
      cooldownTemp = cooldown * compressor;
      workTemp = work * compressor;
      restTemp = rest * compressor;

      times = [];

      for (int i = 0; i < lapsTemp; i++) {
        if (i == 0) {
          times.add(cooldownTemp);
        } else {
          if (i % 2 != 0) {
            times.add(workTemp);
          } else {
            times.add(restTemp);
          }
        }
      }
    });
  }

  void resetTimer() {
    setState(() {
      timer?.cancel();

      secs = times[0];
      maxSecs = times[0];
      currentLap = 0;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ compressor), (_) {
      if (secs > 0 && currentLap != lapsTemp) {
        setState(() => secs--);
        if (secs == 0) {
          currentLap++;
          secs = times[currentLap];
          maxSecs = times[currentLap];

          audioPlayer.play();
        }
      }

      if (currentLap == lapsTemp) secs = 0;
    });
  }

  void stopTimer() {
    setState(() => timer?.cancel());
  }

  void nextLap() {
    if (currentLap < lapsTemp && currentLap + 1 != lapsTemp) {
      setState(() {
        currentLap++;
        secs = times[currentLap];
        maxSecs = times[currentLap];
      });
    } else if (currentLap + 1 == lapsTemp) {
      setState(() {
        currentLap++;
        secs = 0;
      });
    }
  }

  void previousLap() {
    if (currentLap > 0) {
      setState(() {
        currentLap--;
        secs = times[currentLap];
        maxSecs = times[currentLap];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = currentLap == lapsTemp;

    return Scaffold(
      appBar: const AppBarPf(title: "Timer"),
      body: Center(
        child: Column(
          children: [
            buildTopBlock(),
            buildMiddleBlock(),
            Text(
              currentLap == 0
              ? "GET READY"
              : currentLap == lapsTemp
                ? "GREAT WORK"
                : currentLap % 2 != 0
                  ? "WORK"
                  : "REST",
              style: TextStyle(
                color: currentLap % 2 != 0 || currentLap == lapsTemp
                  ? utils.color10
                  : utils.color0Alt,
                fontWeight: FontWeight.w300,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isCompleted
      ? FloatingActionButton.small(
        onPressed: () => resetTimer(),
        backgroundColor: utils.color10,
        child: const Icon(Icons.done),
      )
      : FloatingActionButton.small(
        onPressed: () {
          if (isRunning) {
            stopTimer();
          } else {
            startTimer();
          }
        },
        backgroundColor: utils.color10,
        child: isRunning ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Widget buildTopBlock() {
    return Column(
      children: [
        buildProgressionBar(),
        Container(
          height: 128,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const <Color>[
                utils.color10Alt,
                utils.color10Alt,
                utils.color30,
                utils.color30,
              ],
              stops: [
                0.0,
                (maxSecs - secs) / (maxSecs / 1),
                (maxSecs - secs) / (maxSecs / 1),
                1.0,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    "${currentLap ~/ 2}/$laps",
                    style: const TextStyle(
                      color: utils.color0,
                      fontWeight: FontWeight.w300,
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(width: 12,),
                  const Text(
                    "Work\nlaps",
                    style: TextStyle(
                      color: utils.color0Alt,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              OutlinedButtonPf(
                voidCallback: () => resetTimer(),
                title: "Restart",
                iconData: Icons.restart_alt,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMiddleBlock() {
    return Stack(
      children: [
        buildTimer(),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Center(
            child: OutlinedButtonPf(
              voidCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerSettingsPage(
                      voidCallback: () {
                        Navigator.pop(context);
                        setupTimes();
                      },
                    ),
                  ),
                );
                resetTimer();
              },
              title: "Settings",
              iconData: Icons.settings,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: currentLap != lapsTemp
              ? () => nextLap()
              : null,
              icon: Icon(
                Icons.skip_next,
                size: 32,
                color: currentLap != lapsTemp
                ? utils.color0
                : utils.color0Alt,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: currentLap != 0
              ? () => previousLap()
              : null,
              icon: Icon(
                Icons.skip_previous,
                size: 32,
                color: currentLap != 0
                ? utils.color0
                : utils.color0Alt,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProgressionBar() {
    return LinearProgressIndicator(
      value: (maxSecs - secs) / (maxSecs / 1),
      valueColor: const AlwaysStoppedAnimation(utils.color10),
      backgroundColor: utils.color30,
      minHeight: 3,
    );
  }

  Widget buildTimer() {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 1200,
      axes: <RadialAxis>[
        RadialAxis(
          maximum: 1,
          showLabels: false,
          showTicks: false,
          startAngle: 135,
          endAngle: 45,
          radiusFactor: .7,
          canScaleToFit: true,
          axisLineStyle: const AxisLineStyle(
            thickness: .03,
            color: utils.color30,
            thicknessUnit: GaugeSizeUnit.factor,
            cornerStyle: CornerStyle.bothCurve,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: (maxSecs - secs) / (maxSecs / 1),
              width: .03,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.startCurve,
              gradient: utils.color10gradient,
            ),
            MarkerPointer(
              value: (maxSecs - secs) / (maxSecs / 1),
              markerWidth: 24,
              markerHeight: 24,
              markerType: MarkerType.circle,
              color: utils.color10,
              elevation: 8,
              enableAnimation: true,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              horizontalAlignment: GaugeAlignment.center,
              verticalAlignment: GaugeAlignment.center,
              widget: currentLap == lapsTemp
              ? const Icon(
                Icons.check,
                size: 96,
                color: utils.color10,
              )
              : Text(
                utils.formatTime(secs ~/ compressor),
                style: const TextStyle(
                  color: utils.color0,
                  fontWeight: FontWeight.w300,
                  fontSize: 64,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}